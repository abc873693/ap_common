import 'dart:io';

import 'package:ap_common/api/announcement_helper.dart';
import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/announcement_data.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/scaffold/login_scaffold.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/crashlytics_utils.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:ap_common/widgets/progress_dialog.dart';
import 'package:ap_common/widgets/yes_no_dialog.dart';
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
  static const String routerName = "/announcement";

  final Widget loginDescriptionWidget;
  final Widget reviewDescriptionWidget;
  final bool enableNormalLogin;

  const AnnouncementHomePage({
    Key key,
    this.loginDescriptionWidget,
    this.reviewDescriptionWidget,
    this.enableNormalLogin = false,
  }) : super(key: key);

  @override
  _AnnouncementHomePageState createState() => _AnnouncementHomePageState();
}

class _AnnouncementHomePageState extends State<AnnouncementHomePage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _reviewDescription = TextEditingController();

  ApLocalizations ap;

  _State state = _State.notLogin;

  List<Announcement> announcements;
  List<Announcement> applications;

  bool isOffline = false;

  AnnouncementLoginData loginData;

  FocusNode usernameFocusNode;
  FocusNode passwordFocusNode;

  bool onlyShowNotReview = false;

  TextStyle get _editTextStyle => TextStyle(
        fontSize: 18.0,
        decorationColor: ApTheme.of(context).blueAccent,
      );

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  String _reviewStateText(bool reviewStatus) {
    if (reviewStatus == null)
      return ap.waitingForReview;
    else
      return reviewStatus ? ap.reviewApproval : ap.reviewReject;
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
    ap = ApLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(ap.announcementReviewSystem),
        backgroundColor: ApTheme.of(context).blue,
        actions: [
          if (state == _State.done)
            TextButton(
              child: Row(
                children: [
                  Checkbox(
                    value: onlyShowNotReview,
                    onChanged: (bool value) {
                      setState(() {
                        onlyShowNotReview = value;
                      });
                      Preferences.setBool(
                          ApConstants.ANNOUNCEMENT_ONLY_NOT_REVIEW,
                          onlyShowNotReview);
                    },
                    activeColor: ApTheme.of(context).yellow,
                    checkColor: ApTheme.of(context).blue,
                  ),
                  Text(ap.onlyShowNotReview),
                ],
              ),
              onPressed: () async {
                setState(() {
                  onlyShowNotReview = !onlyShowNotReview;
                });
                Preferences.setBool(ApConstants.ANNOUNCEMENT_ONLY_NOT_REVIEW,
                    onlyShowNotReview);
              },
            ),
          if (Preferences.getBool(ApConstants.ANNOUNCEMENT_IS_LOGIN, false))
            IconButton(
              icon: Icon(Icons.exit_to_app),
              tooltip: ap.logout,
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
      floatingActionButton:
          (loginData == null || loginData?.level == PermissionLevel.user)
              ? null
              : FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () async {
                    var success = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AnnouncementEditPage(
                          mode: Mode.add,
                        ),
                      ),
                    );
                    if (success is bool && success != null && success) {
                      _getAnnouncements();
                    }
                  },
                ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _getAnnouncements();
          await _getApplications();
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
        return InkWell(
          onTap: () {
            _getAnnouncements();
            _getApplications();
          },
          child: HintContent(
            icon: ApIcon.classIcon,
            content: ap.clickToRetry,
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
                              text: '${ap.newsRuleDescription1}\n',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                            TextSpan(
                              text: '${ap.newsRuleDescription2}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '${ap.newsRuleDescription3}',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                  SizedBox(height: 32.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ApButton(
                      text: ap.apply,
                      onPressed: () async {
                        var success = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AnnouncementEditPage(
                              mode: Mode.application,
                            ),
                          ),
                        );
                        if (success ?? false) _getApplications();
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(ap.myApplications),
                  SizedBox(height: 8.0),
                  for (var item in applications)
                    if ((onlyShowNotReview && item.reviewStatus == null) ||
                        (!onlyShowNotReview))
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
                  Text(ap.allAnnouncements),
                  SizedBox(height: 8.0),
                  for (var item in announcements ?? [])
                    _item(_DataType.announcement, item),
                  SizedBox(height: 16.0),
                  Text(ap.allApplications),
                  SizedBox(height: 8.0),
                  for (var item in applications ?? [])
                    if ((onlyShowNotReview && item.reviewStatus == null) ||
                        (!onlyShowNotReview))
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
        labelText: ap.account,
      ),
      style: _editTextStyle,
    );
    Widget passwordTextField = TextField(
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
        labelText: ap.password,
      ),
      style: _editTextStyle,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        widget.loginDescriptionWidget ??
            SelectableText.rich(
              TextSpan(
                style:
                    TextStyle(color: ApTheme.of(context).grey, fontSize: 16.0),
                children: [
                  TextSpan(
                      text: '${ap.newsRuleDescription1}',
                      style: TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: '${ap.newsRuleDescription3}',
                      style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
              textAlign: TextAlign.center,
            ),
        if (widget.enableNormalLogin) ...[
          SizedBox(height: 8.0),
          usernameTextField,
          passwordTextField,
          SizedBox(height: 24.0),
          ApButton(
            text: ap.login,
            onPressed: () async {
              _login(AnnouncementLoginType.normal);
            },
          ),
        ],
        SizedBox(height: widget.enableNormalLogin ? 16.0 : 24.0),
        ApButton(
          text: 'Sign In with Google',
          onPressed: () async {
            _login(AnnouncementLoginType.google);
          },
        ),
        if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) ...[
          SizedBox(height: 16.0),
          ApButton(
            text: 'Sign In with Apple',
            onPressed: () async {
              _login(AnnouncementLoginType.apple);
            },
          ),
        ],
      ],
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
                                title: ap.deleteNewsTitle,
                                contentWidget: Text(
                                  "${ap.deleteNewsContent}",
                                  textAlign: TextAlign.center,
                                ),
                                leftActionText: ap.determine,
                                rightActionText: ap.back,
                                leftActionFunction: () {
                                  AnnouncementHelper.instance
                                      .deleteAnnouncement(
                                    data: item,
                                    callback: GeneralCallback.simple(
                                      context,
                                      (_) {
                                        ApUtils.showToast(
                                            context, ap.updateSuccess);
                                        _reviewDescription.text = '';
                                        _getAnnouncements();
                                      },
                                    ),
                                  );
                                },
                              )
                            : YesNoDialog(
                                title: ap.reviewApplication,
                                contentWidget: TextField(
                                  controller: _reviewDescription,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    fillColor: ApTheme.of(context).blueAccent,
                                    labelStyle: TextStyle(
                                      color: ApTheme.of(context).grey,
                                    ),
                                    labelText: ap.reviewDescription,
                                  ),
                                ),
                                leftActionText: ap.approve,
                                rightActionText: ap.reject,
                                leftActionFunction: () {
                                  AnnouncementHelper.instance
                                      .approveApplication(
                                    applicationId: item.applicationId,
                                    reviewDescription: _reviewDescription.text,
                                    callback: GeneralCallback.simple(
                                      context,
                                      (_) {
                                        ApUtils.showToast(
                                            context, ap.updateSuccess);
                                        _reviewDescription.text = '';
                                        _getAnnouncements();
                                        _getApplications();
                                      },
                                    ),
                                  );
                                },
                                rightActionFunction: () {
                                  AnnouncementHelper.instance.rejectApplication(
                                    applicationId: item.applicationId,
                                    reviewDescription: _reviewDescription.text,
                                    callback: GeneralCallback.simple(
                                      context,
                                      (_) {
                                        ApUtils.showToast(
                                            context, ap.updateSuccess);
                                        _reviewDescription.text = '';
                                        _getAnnouncements();
                                        _getApplications();
                                      },
                                    ),
                                  );
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
                        if (loginData.level != PermissionLevel.user &&
                            dataType == _DataType.application) ...[
                          TextSpan(
                            text: '${ap.applicant}：',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '${item.applicant ?? ''}\n'),
                        ],
                        if (loginData.level != PermissionLevel.user) ...[
                          TextSpan(
                            text: '${ap.weight}：',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '${item.weight ?? 1}\n'),
                        ],
                        TextSpan(
                          text: '${ap.imageUrl}：',
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
                          text: '\n${ap.url}：',
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
                          text: '\n${ap.expireTime}：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: '${item.expireTime ?? ap.noExpiration}\n'),
                        TextSpan(
                          text: '${ap.description}：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${item.description}'),
                        TextSpan(
                          text: '\n${ap.reviewDescription}：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${item.reviewDescription ?? ''}'),
                        if (dataType == _DataType.application &&
                            loginData.level != PermissionLevel.user) ...[
                          TextSpan(text: '\n${ap.reviewState}：'),
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
                      MaterialPageRoute(
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
                        _getAnnouncements();
                        _getApplications();
                      }
                    }
                  },
      ),
    );
  }

  Future<void> _getAnnouncements() async {
    AnnouncementHelper.instance.getAllAnnouncements(
      callback: GeneralCallback.simple(
        context,
        (List<Announcement> data) {
          this.announcements = data;
          setState(() => state = _State.done);
        },
      ),
    );
  }

  Future<void> _getApplications() async {
    AnnouncementHelper.instance.getApplications(
      callback: GeneralCallback.simple(
        context,
        (List<Announcement> data) {
          this.applications = data;
          setState(() => state = _State.done);
        },
      ),
    );
  }

  _getPreference() async {
    await Future.delayed(Duration(microseconds: 50));
    bool isLogin =
        Preferences.getBool(ApConstants.ANNOUNCEMENT_IS_LOGIN, false);
    onlyShowNotReview =
        Preferences.getBool(ApConstants.ANNOUNCEMENT_ONLY_NOT_REVIEW, false);
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
      ApUtils.showToast(context, ap.doNotEmpty);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => WillPopScope(
            child: ProgressDialog(ap.logining),
            onWillPop: () async {
              return false;
            }),
        barrierDismissible: false,
      );
      String idToken =
          Preferences.getBool(ApConstants.ANNOUNCEMENT_IS_LOGIN, false)
              ? Preferences.getStringSecurity(
                  ApConstants.ANNOUNCEMENT_ID_TOKEN, null)
              : null;

      final callback = GeneralCallback<AnnouncementLoginData>(
        onError: (response) {
          Navigator.of(context, rootNavigator: true).pop();
          ApUtils.showToast(context, response.message);
        },
        onFailure: (dioError) async {
          Navigator.of(context, rootNavigator: true).pop();
          ApUtils.showToast(context, dioError.i18nMessage);
          if (dioError.type == DioErrorType.RESPONSE &&
              dioError.response.statusCode == 403) {
            if (loginType == AnnouncementLoginType.google)
              await _googleSignIn.signOut();
          }
        },
        onSuccess: (loginData) {
          this.loginData = loginData;
          if (kDebugMode) print(loginData.key);
          Navigator.of(context, rootNavigator: true).pop();
          if (loginType == AnnouncementLoginType.normal)
            Preferences.setStringSecurity(
                ApConstants.ANNOUNCEMENT_PASSWORD, _password.text);
          else
            Preferences.setStringSecurity(
                ApConstants.ANNOUNCEMENT_ID_TOKEN, idToken);
          ApUtils.showToast(context, ap.loginSuccess);
          Preferences.setBool(ApConstants.ANNOUNCEMENT_IS_LOGIN, true);
          Preferences.setInt(
              ApConstants.ANNOUNCEMENT_LOGIN_TYPE, loginType.index);
          setState(() {
            state = _State.loading;
            if (loginData.level != PermissionLevel.user) _getAnnouncements();
            _getApplications();
          });
        },
      );
      print(loginType);
      switch (loginType) {
        case AnnouncementLoginType.normal:
          Preferences.setString(
              ApConstants.ANNOUNCEMENT_USERNAME, _username.text);
          AnnouncementHelper.instance.login(
            username: _username.text,
            password: _password.text,
            callback: callback,
          );
          break;
        case AnnouncementLoginType.google:
          try {
            final isSignIn = await _googleSignIn.isSignedIn();
            var data = isSignIn
                ? await _googleSignIn.signInSilently()
                : await _googleSignIn.signIn();
            if (data != null) {
              final authentication = await data.authentication;
              idToken = authentication.idToken;
              AnnouncementHelper.instance
                  .googleLogin(idToken: idToken, callback: callback);
            } else
              Navigator.of(context, rootNavigator: true).pop();
          } catch (e, s) {
            ApUtils.showToast(context, ap.thirdPartyLoginFail);
            CrashlyticsUtils.instance?.recordError(e, s);
            Navigator.of(context, rootNavigator: true).pop();
            if (CrashlyticsUtils.instance != null) throw e;
          }
          break;
        case AnnouncementLoginType.apple:
          try {
            if (idToken == null) {
              final credential = await SignInWithApple.getAppleIDCredential(
                scopes: [AppleIDAuthorizationScopes.email],
              );
              idToken = credential.identityToken;
            }
            AnnouncementHelper.instance
                .appleLogin(idToken: idToken, callback: callback);
          } catch (e, s) {
            ApUtils.showToast(context, ap.thirdPartyLoginFail);
            Navigator.of(context, rootNavigator: true).pop();
            CrashlyticsUtils.instance?.recordError(e, s);
          }
          break;
      }
    }
  }
}
