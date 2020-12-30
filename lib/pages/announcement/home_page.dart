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

import 'edit_page.dart';

enum _State { notLogin, loading, user, admin, error, empty, offline }

class AnnouncementHomePage extends StatefulWidget {
  static const String routerName = "/news/admin";

  const AnnouncementHomePage({Key key}) : super(key: key);

  @override
  _AnnouncementHomePageState createState() => _AnnouncementHomePageState();
}

class _AnnouncementHomePageState extends State<AnnouncementHomePage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  ApLocalizations app;

  _State state = _State.notLogin;

  List<Announcement> announcements;

  bool isOffline = false;
  FocusNode usernameFocusNode;
  FocusNode passwordFocusNode;

  TextStyle get _editTextStyle => TextStyle(
        fontSize: 18.0,
        decorationColor: ApTheme.of(context).blueAccent,
      );

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

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
      ),
      floatingActionButton: state == _State.notLogin
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
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case _State.empty:
      case _State.error:
        return FlatButton(
          onPressed: () {
            _getData();
          },
          child: HintContent(
            icon: ApIcon.classIcon,
            content: app.clickToRetry,
          ),
        );
      case _State.offline:
        return HintContent(
          icon: ApIcon.classIcon,
          content: app.noOfflineData,
        );
      case _State.user:
      case _State.admin:
        return ListView.builder(
          itemBuilder: (_, index) {
            return _item(announcements[index]);
          },
          itemCount: announcements.length,
        );
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
          SizedBox(height: 32.0),
          ApButton(
            text: 'Google Sign out',
            onPressed: () async {
              var data = await _googleSignIn.signOut();
            },
          ),
        ],
      ),
    );
  }

  Widget _item(Announcement item) {
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
            trailing: IconButton(
              icon: Icon(
                ApIcon.cancel,
                color: ApTheme.of(context).red,
              ),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => YesNoDialog(
                    title: app.deleteNewsTitle,
                    contentWidget: Text(
                      "${app.deleteNewsContent}",
                      textAlign: TextAlign.center,
                    ),
                    leftActionText: app.back,
                    rightActionText: app.determine,
                    rightActionFunction: () {
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
                  ),
                );
              },
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: ApTheme.of(context).grey,
                      height: 1.3,
                      fontSize: 16.0),
                  children: [
                    TextSpan(
                      text: '${app.weight}：',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '${item.weight ?? 1}\n'),
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
                    TextSpan(text: '${item.expireTime ?? app.noExpiration}\n'),
                    TextSpan(
                      text: '${app.description}：',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '${item.description}'),
                  ],
                ),
              ),
            ),
          ),
        ),
        onTap: () async {
          var success = await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => AnnouncementEditPage(
                mode: Mode.edit,
                announcement: item,
              ),
            ),
          );
          if (success is bool && success != null) {
            if (success) {
              _getData();
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
        state = announcementsData.length == 0 ? _State.empty : _State.admin;
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
      switch (loginType) {
        case AnnouncementLoginType.normal:
          Preferences.setString(
              ApConstants.ANNOUNCEMENT_USERNAME, _username.text);
          login = AnnouncementHelper.instance
              .login(username: _username.text, password: _password.text);
          break;
        case AnnouncementLoginType.google:
          print((await _googleSignIn.isSignedIn()));
          var data = await _googleSignIn.signIn();
          print((await data.authentication).idToken);
          login = AnnouncementHelper.instance
              .googleLogin(idToken: (await data.authentication).idToken);
          break;
        case AnnouncementLoginType.apple:
          // TODO: Handle this case.
          break;
      }
      login.then((AnnouncementLoginData response) async {
        Navigator.of(context, rootNavigator: true).pop();
        Preferences.setStringSecurity(
            ApConstants.ANNOUNCEMENT_PASSWORD, _password.text);
        ApUtils.showToast(context, app.loginSuccess);
        Preferences.setBool(ApConstants.ANNOUNCEMENT_IS_LOGIN, true);
        Preferences.setInt(
            ApConstants.ANNOUNCEMENT_LOGIN_TYPE, loginType.index);
        setState(() {
          state = _State.loading;
          _getData();
        });
      }).catchError((e) {
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
