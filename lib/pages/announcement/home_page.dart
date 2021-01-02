import 'dart:io';

import 'package:ap_common/api/announcement_helper.dart';
import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/announcement_data.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/scaffold/login_scaffold.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:ap_common/widgets/progress_dialog.dart';
import 'package:ap_common/widgets/yes_no_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'edit_page.dart';

enum _State { notLogin, loading, done, error }
enum _DataType { announcement, application }

class AnnouncementHomePage extends StatefulWidget {
  static const String routerName = "/news/admin";
  final Widget reviewDescriptionWidget;

  const AnnouncementHomePage({
    Key key,
    this.reviewDescriptionWidget,
  }) : super(key: key);

  @override
  _AnnouncementHomePageState createState() => _AnnouncementHomePageState();
}

class _AnnouncementHomePageState extends State<AnnouncementHomePage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _reviewDescription = TextEditingController();

  ApLocalizations app;

  _State state = _State.notLogin;

  List<Announcement> announcements;
  List<Announcement> applications;

  bool isOffline = false;

  AnnouncementLoginData loginData;

  FocusNode usernameFocusNode;
  FocusNode passwordFocusNode;

  TextStyle get _editTextStyle => TextStyle(
        fontSize: 18.0,
        decorationColor: ApTheme.of(context).blueAccent,
      );

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  String _reviewStateText(bool reviewStatus) {
    if (reviewStatus == null)
      return app.waitingForReview;
    else
      return reviewStatus ? app.reviewApproval : app.reviewReject;
  }

  @override
  void initState() {
    //FA.setCurrentScreen('ScorePage', 'score_page.dart');
    _getPreference();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    app = ApLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(app.announcements),
        backgroundColor: ApTheme.of(context).blue,
        actions: [
          if (Preferences.getBool(ApConstants.ANNOUNCEMENT_IS_LOGIN, false))
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                if (AnnouncementHelper.loginType ==
                    AnnouncementLoginType.google) await _googleSignIn.signOut();
                setState(() {
                  Preferences.setBool(ApConstants.ANNOUNCEMENT_IS_LOGIN, false);
                  state = _State.notLogin;
                });
              },
            ),
        ],
      ),
      floatingActionButton: (loginData?.level == PermissionLevel.user ?? false)
          ? null
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                var success = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => AnnouncementEditPage(
                      mode: Mode.add,
                    ),
                  ),
                );
                if (success is bool && success != null && success) {
                  _getData();
                }
              },
            ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _getData();
          await _getApplicationData();
          return null;
        },
        child: _body(),
      ),
    );
  }

  _body() {
    switch (state) {
      case _State.notLogin:
        return _loginContent();
      case _State.loading:
        return Container(
          child: CircularProgressIndicator(),
          alignment: Alignment.center,
        );
      case _State.error:
        return FlatButton(
          onPressed: () {
            _getData();
            _getApplicationData();
          },
          child: HintContent(
            icon: ApIcon.classIcon,
            content: app.clickToRetry,
          ),
        );
      case _State.done:
        switch (loginData.level) {
          case PermissionLevel.user:
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.0),
                  widget.reviewDescriptionWidget ??
                      SelectableText.rich(
                        TextSpan(
                          style: TextStyle(
                              color: ApTheme.of(context).grey, fontSize: 16.0),
                          children: [
                            TextSpan(
                                text: '${app.newsRuleDescription1}',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: '${app.newsRuleDescription2}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${app.newsRuleDescription3}',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                  SizedBox(height: 32.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ApButton(
                      text: app.apply,
                      onPressed: () async {
                        var success = await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => AnnouncementEditPage(
                              mode: Mode.application,
                            ),
                          ),
                        );
                        if (success ?? false) _getApplicationData();
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(app.myApplications),
                  SizedBox(height: 8.0),
                  for (var item in applications)
                    _item(_DataType.application, item)
                ],
              ),
            );
          case PermissionLevel.editor:
          case PermissionLevel.admin:
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.0),
                  Text(app.allAnnouncements),
                  SizedBox(height: 8.0),
                  for (var item in announcements ?? [])
                    _item(_DataType.announcement, item),
                  SizedBox(height: 16.0),
                  Text(app.allApplications),
                  SizedBox(height: 8.0),
                  for (var item in applications ?? [])
                    _item(_DataType.application, item)
                ],
              ),
            );
        }
    }
  }

  _loginContent() {
    Widget usernameTextField = TextField(
      maxLines: 1,
      controller: _username,
      textInputAction: TextInputAction.next,
      focusNode: usernameFocusNode,
      onSubmitted: (text) {
        usernameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
      decoration: InputDecoration(
        labelText: app.username,
      ),
      style: _editTextStyle,
    );
    Widget passwordTextField = TextField(
      // obscureText: true,
      maxLines: 1,
      textInputAction: TextInputAction.send,
      controller: _password,
      focusNode: passwordFocusNode,
      onSubmitted: (text) {
        passwordFocusNode.unfocus();
        _login(AnnouncementLoginType.normal);
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: app.password,
      ),
      style: _editTextStyle,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 32.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          usernameTextField,
          passwordTextField,
          SizedBox(height: 32.0),
          ApButton(
            text: app.login,
            onPressed: () async {
              _login(AnnouncementLoginType.normal);
            },
          ),
          SizedBox(height: 32.0),
          ApButton(
            text: 'Google Sign in',
            onPressed: () async {
              _login(AnnouncementLoginType.google);
            },
          ),
          if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) ...[
            SizedBox(height: 32.0),
            ApButton(
              text: 'Sign In With Apple',
              onPressed: () async {
                _login(AnnouncementLoginType.apple);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _item(_DataType dataType, Announcement item) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        radius: 12.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              item.title,
              style: TextStyle(fontSize: 18.0),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (loginData.level != PermissionLevel.user &&
                    item.reviewStatus == null)
                  IconButton(
                    icon: Icon(
                      dataType == _DataType.announcement
                          ? ApIcon.cancel
                          : Icons.approval,
                      color: dataType == _DataType.announcement
                          ? ApTheme.of(context).red
                          : ApTheme.of(context).yellow,
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => dataType ==
                                _DataType.announcement
                            ? YesNoDialog(
                                title: app.deleteNewsTitle,
                                contentWidget: Text(
                                  "${app.deleteNewsContent}",
                                  textAlign: TextAlign.center,
                                ),
                                leftActionText: app.determine,
                                rightActionText: app.back,
                                leftActionFunction: () {
                                  AnnouncementHelper.instance
                                      .deleteAnnouncement(item)
                                      .then((response) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(app.deleteSuccess),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    _getData();
                                  }).catchError((e) {
                                    if (e is DioError) {
                                      switch (e.type) {
                                        case DioErrorType.RESPONSE:
                                          ApUtils.showToast(
                                              context, e.response?.data ?? '');
                                          break;
                                        case DioErrorType.CANCEL:
                                          break;
                                        default:
                                          ApUtils.handleDioError(context, e);
                                          break;
                                      }
                                    } else {
                                      throw e;
                                    }
                                  });
                                },
                              )
                            : YesNoDialog(
                                title: app.reviewApplication,
                                contentWidget: TextField(
                                  controller: _reviewDescription,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    fillColor: ApTheme.of(context).blueAccent,
                                    labelStyle: TextStyle(
                                      color: ApTheme.of(context).grey,
                                    ),
                                    labelText: app.reviewDescription,
                                  ),
                                ),
                                leftActionText: app.approve,
                                rightActionText: app.reject,
                                leftActionFunction: () {
                                  AnnouncementHelper.instance
                                      .approveApplication(
                                    applicationId: item.applicationId,
                                    reviewDescription: _reviewDescription.text,
                                  )
                                      .then((response) {
                                    ApUtils.showToast(
                                        context, app.updateSuccess);
                                    _reviewDescription.text = '';
                                    _getData();
                                    _getApplicationData();
                                  });
                                },
                                rightActionFunction: () {
                                  AnnouncementHelper.instance
                                      .rejectApplication(
                                    applicationId: item.applicationId,
                                    reviewDescription: _reviewDescription.text,
                                  )
                                      .then((response) {
                                    ApUtils.showToast(
                                        context, app.updateSuccess);
                                    _reviewDescription.text = '';
                                    _getData();
                                    _getApplicationData();
                                  });
                                },
                              ),
                      );
                    },
                  ),
                if (dataType == _DataType.application &&
                    loginData.level == PermissionLevel.user)
                  Text(
                    _reviewStateText(item.reviewStatus),
                    style: TextStyle(
                      color: item.reviewStatus ?? false
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: ApTheme.of(context).grey,
                          height: 1.3,
                          fontSize: 16.0),
                      children: [
                        if (loginData.level != PermissionLevel.user) ...[
                          TextSpan(
                            text: '${app.weight}：',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '${item.weight ?? 1}\n'),
                        ],
                        TextSpan(
                          text: '${app.imageUrl}：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${item.imgUrl}',
                          style: TextStyle(
                            color: ApTheme.of(context).blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ApUtils.launchUrl(item.imgUrl);
                            },
                        ),
                        TextSpan(
                          text: '\n${app.url}：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${item.url}',
                          style: TextStyle(
                            color: ApTheme.of(context).blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ApUtils.launchUrl(item.url);
                            },
                        ),
                        TextSpan(
                          text: '\n${app.expireTime}：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: '${item.expireTime ?? app.noExpiration}\n'),
                        TextSpan(
                          text: '${app.description}：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${item.description}'),
                        TextSpan(
                          text: '\n${app.reviewDescription}：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${item.reviewDescription ?? ''}'),
                        if (dataType == _DataType.application &&
                            loginData.level != PermissionLevel.user) ...[
                          TextSpan(text: '\n${app.reviewState}：'),
                          TextSpan(
                            text: _reviewStateText(item.reviewStatus),
                            style: TextStyle(
                              color: item.reviewStatus ?? false
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap:
            loginData.level == PermissionLevel.user || item.reviewStatus != null
                ? null
                : () async {
                    var success = await Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => AnnouncementEditPage(
                          mode: dataType == _DataType.announcement
                              ? Mode.edit
                              : Mode.editApplication,
                          announcement: item,
                        ),
                      ),
                    );
                    if (success ?? false) {
                      if (success) {
                        _getData();
                        _getApplicationData();
                      }
                    }
                  },
      ),
    );
  }

  _getData() async {
    AnnouncementHelper.instance.getAllAnnouncements().then((announcementsData) {
      this.announcements = announcementsData;
      setState(() {
        state = _State.done;
      });
    });
  }

  _getApplicationData() async {
    AnnouncementHelper.instance.getApplications().then((announcementsData) {
      this.applications = announcementsData;
      setState(() {
        state = _State.done;
      });
    });
  }

  _getPreference() async {
    await Future.delayed(Duration(microseconds: 50));
    bool isLogin =
        Preferences.getBool(ApConstants.ANNOUNCEMENT_IS_LOGIN, false);
    _username.text =
        Preferences.getString(ApConstants.ANNOUNCEMENT_USERNAME, '');
    _password.text =
        Preferences.getStringSecurity(ApConstants.ANNOUNCEMENT_PASSWORD, '');
    if (isLogin) {
      int index = Preferences.getInt(ApConstants.ANNOUNCEMENT_LOGIN_TYPE, 0);
      _login(AnnouncementLoginType.values[index]);
    } else {
      usernameFocusNode = FocusNode();
      passwordFocusNode = FocusNode();
      setState(() {});
    }
  }

  void _login(AnnouncementLoginType loginType) async {
    if (loginType == AnnouncementLoginType.normal &&
        (_username.text.isEmpty || _password.text.isEmpty)) {
      ApUtils.showToast(context, app.doNotEmpty);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => WillPopScope(
            child: ProgressDialog(app.logining),
            onWillPop: () async {
              return false;
            }),
        barrierDismissible: false,
      );
      Future<AnnouncementLoginData> login;
      String idToken =
          Preferences.getBool(ApConstants.ANNOUNCEMENT_IS_LOGIN, false)
              ? Preferences.getStringSecurity(
                  ApConstants.ANNOUNCEMENT_ID_TOKEN, null)
              : null;
      switch (loginType) {
        case AnnouncementLoginType.normal:
          Preferences.setString(
              ApConstants.ANNOUNCEMENT_USERNAME, _username.text);
          login = AnnouncementHelper.instance
              .login(username: _username.text, password: _password.text);
          break;
        case AnnouncementLoginType.google:
          var data = await _googleSignIn.isSignedIn()
              ? await _googleSignIn.signInSilently()
              : await _googleSignIn.signIn();
          idToken = (await data.authentication).idToken;
          login = AnnouncementHelper.instance.googleLogin(idToken: idToken);
          break;
        case AnnouncementLoginType.apple:
          try {
            if (idToken == null) {
              final credential = await SignInWithApple.getAppleIDCredential(
                scopes: [AppleIDAuthorizationScopes.email],
              );
              idToken = credential.identityToken;
            }
            login = AnnouncementHelper.instance.appleLogin(idToken: idToken);
          } catch (e) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          break;
      }
      login?.then((AnnouncementLoginData response) async {
        loginData = response;
        if (kDebugMode) print(loginData.key);
        Navigator.of(context, rootNavigator: true).pop();
        if (loginType == AnnouncementLoginType.normal)
          Preferences.setStringSecurity(
              ApConstants.ANNOUNCEMENT_PASSWORD, _password.text);
        else
          Preferences.setStringSecurity(
              ApConstants.ANNOUNCEMENT_ID_TOKEN, idToken);
        ApUtils.showToast(context, app.loginSuccess);
        Preferences.setBool(ApConstants.ANNOUNCEMENT_IS_LOGIN, true);
        Preferences.setInt(
            ApConstants.ANNOUNCEMENT_LOGIN_TYPE, loginType.index);
        setState(() {
          state = _State.loading;
          if (loginData.level != PermissionLevel.user) _getData();
          _getApplicationData();
        });
      })?.catchError((e) {
        Navigator.of(context, rootNavigator: true).pop();
        if (e is DioError) {
          switch (e.type) {
            case DioErrorType.RESPONSE:
              ApUtils.showToast(context, app.loginFail);
              break;
            case DioErrorType.CANCEL:
              break;
            default:
              ApUtils.handleDioError(context, e);
              break;
          }
        } else {
          throw e;
        }
      });
    }
  }
}
