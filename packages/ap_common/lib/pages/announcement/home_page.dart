import 'dart:io';

import 'package:ap_common/api/announcement_helper.dart';
import 'package:ap_common/pages/announcement/black_list_page.dart';
import 'package:ap_common/pages/announcement/edit_page.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/scaffold/login_scaffold.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:ap_common/widgets/progress_dialog.dart';
import 'package:ap_common/widgets/yes_no_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sprintf/sprintf.dart';

enum _State { notLogin, loading, done, error }

enum _DataType { announcement, application }

class AnnouncementHomePage extends StatefulWidget {
  const AnnouncementHomePage({
    super.key,
    this.loginDescriptionWidget,
    this.reviewDescriptionWidget,
    this.organizationDomain,
    this.enableNormalLogin = false,
  });

  final Widget? loginDescriptionWidget;
  final Widget? reviewDescriptionWidget;
  final String? organizationDomain;
  final bool enableNormalLogin;

  static const String routerName = '/announcement';

  @override
  _AnnouncementHomePageState createState() => _AnnouncementHomePageState();
}

class _AnnouncementHomePageState extends State<AnnouncementHomePage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _reviewDescription = TextEditingController();

  ApLocalizations get ap => ApLocalizations.of(context);

  _State state = _State.notLogin;

  List<Announcement>? announcements;
  List<Announcement>? applications;

  bool isOffline = false;

  AnnouncementLoginData? loginData;

  FocusNode? usernameFocusNode;
  FocusNode? passwordFocusNode;

  bool? onlyShowNotReview = false;

  TextStyle get _defaultStyle => TextStyle(
        color: ApTheme.of(context).grey,
        height: 1.3,
        fontSize: 16.0,
      );

  TextStyle get _editTextStyle => TextStyle(
        fontSize: 18.0,
        decorationColor: ApTheme.of(context).blueAccent,
      );

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );

  String _reviewStateText(bool? reviewStatus) {
    if (reviewStatus == null) {
      return ap.waitingForReview;
    } else {
      return reviewStatus ? ap.reviewApproval : ap.reviewReject;
    }
  }

  @override
  void initState() {
    //FA.setCurrentScreen('ScorePage', 'score_page.dart');
    Future<dynamic>.microtask(
      () => _getPreference(),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ap.announcementReviewSystem),
        backgroundColor: ApTheme.of(context).blue,
        actions: <Widget>[
          if (state == _State.done &&
              loginData?.level != PermissionLevel.user) ...<Widget>[
            TextButton(
              onPressed: () async {
                setState(() {
                  onlyShowNotReview = !onlyShowNotReview!;
                });
                PreferenceUtil.instance.setBool(
                  ApConstants.announcementOnlyNotReview,
                  onlyShowNotReview!,
                );
              },
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: onlyShowNotReview,
                    onChanged: (bool? value) {
                      setState(() {
                        onlyShowNotReview = value;
                      });
                      PreferenceUtil.instance.setBool(
                        ApConstants.announcementOnlyNotReview,
                        onlyShowNotReview!,
                      );
                    },
                    activeColor: ApTheme.of(context).yellow,
                    checkColor: ApTheme.of(context).blue,
                  ),
                  Text(
                    ap.onlyShowNotReview,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.playlist_remove),
              tooltip: ap.blackList,
              onPressed: () async {
                ApUtils.pushCupertinoStyle(
                  context,
                  const BlackListPage(),
                );
              },
            ),
          ],
          if (PreferenceUtil.instance
              .getBool(ApConstants.announcementIsLogin, false))
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: ap.logout,
              onPressed: () async {
                if (AnnouncementHelper.instance.loginType ==
                    AnnouncementLoginType.google) await _googleSignIn.signOut();
                setState(() {
                  PreferenceUtil.instance.setBool(
                    ApConstants.announcementIsLogin,
                    false,
                  );
                  state = _State.notLogin;
                  loginData = null;
                });
              },
            ),
        ],
      ),
      floatingActionButton:
          (loginData == null || loginData?.level == PermissionLevel.user)
              ? null
              : FloatingActionButton(
                  onPressed: () async {
                    final dynamic success = await Navigator.push(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (_) => const AnnouncementEditPage(
                          mode: Mode.add,
                        ),
                      ),
                    );
                    if (success is bool && success) {
                      _getAnnouncements();
                    }
                  },
                  child: const Icon(Icons.add),
                ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _getAnnouncements();
          await _getApplications();
          return;
        },
        child: _body(),
      ),
    );
  }

  Widget _body() {
    switch (state) {
      case _State.notLogin:
        return _loginContent();
      case _State.loading:
        return Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
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
        switch (loginData?.level ?? PermissionLevel.user) {
          case PermissionLevel.user:
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 8.0),
                  widget.reviewDescriptionWidget ??
                      SelectableText.rich(
                        TextSpan(
                          style: TextStyle(
                            color: ApTheme.of(context).grey,
                            fontSize: 16.0,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${sprintf(
                                ap.newsRuleDescription1,
                                <String>[
                                  widget.organizationDomain ?? '',
                                ],
                              )}\n',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: ap.newsRuleDescription2,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: ap.newsRuleDescription3,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                  const SizedBox(height: 32.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ApButton(
                      text: ap.apply,
                      onPressed: () async {
                        final dynamic success = await Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (_) => const AnnouncementEditPage(
                              mode: Mode.application,
                            ),
                          ),
                        );
                        if (success is bool && success) {
                          _getApplications();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(ap.myApplications),
                  const SizedBox(height: 8.0),
                  for (final Announcement item
                      in applications ?? <Announcement>[])
                    if ((onlyShowNotReview! && item.reviewStatus == null) ||
                        (!onlyShowNotReview!))
                      _item(_DataType.application, item),
                ],
              ),
            );
          case PermissionLevel.editor:
          case PermissionLevel.admin:
            return SingleChildScrollView(
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 8.0, width: double.infinity),
                    Text(ap.allApplications),
                    const SizedBox(height: 8.0),
                    for (final Announcement item
                        in applications ?? <Announcement>[])
                      if ((onlyShowNotReview! && item.reviewStatus == null) ||
                          (!onlyShowNotReview!))
                        _item(_DataType.application, item),
                    const SizedBox(height: 16.0),
                    Text(ap.allAnnouncements),
                    const SizedBox(height: 8.0),
                    for (final Announcement item
                        in announcements ?? <Announcement>[])
                      _item(_DataType.announcement, item),
                  ],
                ),
              ),
            );
        }
    }
  }

  Widget _loginContent() {
    final Widget usernameTextField = TextField(
      controller: _username,
      textInputAction: TextInputAction.next,
      focusNode: usernameFocusNode,
      onSubmitted: (String text) {
        usernameFocusNode?.unfocus();
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
      decoration: InputDecoration(
        labelText: ap.account,
      ),
      style: _editTextStyle,
    );
    final Widget passwordTextField = TextField(
      textInputAction: TextInputAction.send,
      controller: _password,
      focusNode: passwordFocusNode,
      onSubmitted: (String text) {
        passwordFocusNode?.unfocus();
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
      children: <Widget>[
        widget.loginDescriptionWidget ??
            SelectableText.rich(
              TextSpan(
                style:
                    TextStyle(color: ApTheme.of(context).grey, fontSize: 16.0),
                children: <TextSpan>[
                  TextSpan(
                    text: sprintf(
                      ap.newsRuleDescription1,
                      <String>[
                        widget.organizationDomain ?? '',
                      ],
                    ),
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: ap.newsRuleDescription3,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
        if (widget.enableNormalLogin) ...<Widget>[
          const SizedBox(height: 8.0),
          usernameTextField,
          passwordTextField,
          const SizedBox(height: 24.0),
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
        if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) ...<Widget>[
          const SizedBox(height: 16.0),
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
      child: GestureDetector(
        onLongPress: loginData?.level == PermissionLevel.user ||
                item.reviewStatus != null
            ? null
            : () async {
                final dynamic success = await Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (_) => AnnouncementEditPage(
                      mode: dataType == _DataType.announcement
                          ? Mode.edit
                          : Mode.editApplication,
                      announcement: item,
                    ),
                  ),
                );
                if (success is bool && success) {
                  _getAnnouncements();
                  _getApplications();
                }
              },
        child: ExpansionTile(
          childrenPadding: const EdgeInsets.symmetric(horizontal: 24.0),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              item.title,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (loginData?.level != PermissionLevel.user &&
                  item.reviewStatus == null) ...<Widget>[
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
                      builder: (_) => dataType == _DataType.announcement
                          ? YesNoDialog(
                              title: ap.deleteNewsTitle,
                              contentWidget: Text(
                                ap.deleteNewsContent,
                                textAlign: TextAlign.center,
                              ),
                              leftActionText: ap.determine,
                              rightActionText: ap.back,
                              leftActionFunction: () {
                                AnnouncementHelper.instance.deleteAnnouncement(
                                  data: item,
                                  // ignore: always_specify_types
                                  callback: GeneralCallback.simple(
                                    context,
                                    (_) {
                                      ApUtils.showToast(
                                        context,
                                        ap.updateSuccess,
                                      );
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
                                  border: const OutlineInputBorder(),
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
                                AnnouncementHelper.instance.approveApplication(
                                  applicationId: item.applicationId,
                                  reviewDescription: _reviewDescription.text,
                                  // ignore: always_specify_types
                                  callback: GeneralCallback.simple(
                                    context,
                                    (_) {
                                      ApUtils.showToast(
                                        context,
                                        ap.updateSuccess,
                                      );
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
                                  // ignore: always_specify_types
                                  callback: GeneralCallback.simple(
                                    context,
                                    (_) {
                                      ApUtils.showToast(
                                        context,
                                        ap.updateSuccess,
                                      );
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
              ],
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (dataType == _DataType.application)
                RichText(
                  text: TextSpan(
                    style: _defaultStyle,
                    children: <TextSpan>[
                      TextSpan(text: '${ap.reviewState}：'),
                      TextSpan(
                        text: _reviewStateText(item.reviewStatus),
                        style: TextStyle(
                          color: item.reviewStatus ?? false
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              if (loginData!.level != PermissionLevel.user)
                Wrap(
                  children: <Widget>[
                    for (final String? tag
                        in item.tags ?? <String>[]) ...<Widget>[
                      Chip(
                        label: Text(tag!),
                        backgroundColor: tag.color,
                      ),
                      const SizedBox(width: 8.0),
                    ],
                  ],
                ),
            ],
          ),
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: _defaultStyle,
                children: <TextSpan>[
                  if (loginData!.level != PermissionLevel.user) ...<TextSpan>[
                    TextSpan(
                      text: '${ap.weight}：',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '${item.weight}\n'),
                  ],
                  TextSpan(
                    text: '${ap.imageUrl}：',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: item.imgUrl,
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: item.url,
                    style: TextStyle(
                      color: ApTheme.of(context).blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ApUtils.launchUrl(item.url!);
                      },
                  ),
                  TextSpan(
                    text: '\n${ap.expireTime}：',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '${item.expireTime ?? ap.noExpiration}\n'),
                  TextSpan(
                    text: '${ap.description}：',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: item.description),
                  TextSpan(
                    text: '\n${ap.reviewDescription}：',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: item.reviewDescription ?? ''),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Future<void> _getAnnouncements() async {
    AnnouncementHelper.instance.getAllAnnouncements(
      // ignore: always_specify_types
      callback: GeneralCallback.simple(
        context,
        (List<Announcement>? data) {
          announcements = data;
          setState(() => state = _State.done);
        },
      ),
    );
  }

  Future<void> _getApplications() async {
    AnnouncementHelper.instance.getApplications(
      // ignore: always_specify_types
      callback: GeneralCallback.simple(
        context,
        (List<Announcement>? data) {
          applications = data;
          setState(() => state = _State.done);
        },
      ),
    );
  }

  Future<void> _getPreference() async {
    final bool isLogin =
        PreferenceUtil.instance.getBool(ApConstants.announcementIsLogin, false);
    onlyShowNotReview = PreferenceUtil.instance
        .getBool(ApConstants.announcementOnlyNotReview, false);
    _username.text =
        PreferenceUtil.instance.getString(ApConstants.announcementUsername, '');
    _password.text = PreferenceUtil.instance.getStringSecurity(
      ApConstants.announcementPassword,
      '',
    );
    if (isLogin) {
      setState(() => state = _State.done);
      loginData = AnnouncementLoginData.load();
      if (kDebugMode) {
        debugPrint(
          'token is expire = '
          '${loginData?.isExpired} '
          'level = ${loginData!.level} '
          'token = ${loginData!.key}',
        );
      }
      if (loginData?.isExpired ?? true) {
        final int index = PreferenceUtil.instance
            .getInt(ApConstants.announcementLoginType, 0);
        _login(AnnouncementLoginType.values[index]);
      } else {
        AnnouncementHelper.instance.setAuthorization(loginData!.key);
        setState(() {
          if (loginData!.level != PermissionLevel.user) _getAnnouncements();
          _getApplications();
        });
      }
    } else {
      usernameFocusNode = FocusNode();
      passwordFocusNode = FocusNode();
      setState(() {});
    }
  }

  Future<void> _login(AnnouncementLoginType loginType) async {
    if (loginType == AnnouncementLoginType.normal &&
        (_username.text.isEmpty || _password.text.isEmpty)) {
      ApUtils.showToast(context, ap.doNotEmpty);
    } else {
      final bool isNotLogin = !PreferenceUtil.instance
          .getBool(ApConstants.announcementIsLogin, false);
      if (isNotLogin) {
        showDialog(
          context: context,
          builder: (BuildContext context) => PopScope(
            canPop: false,
            child: ProgressDialog(ap.logining),
          ),
          barrierDismissible: false,
        );
      }
      String? idToken = PreferenceUtil.instance.getBool(
        ApConstants.announcementIsLogin,
        false,
      )
          ? PreferenceUtil.instance.getStringSecurity(
              ApConstants.announcementIdToken,
              '',
            )
          : '';

      final GeneralCallback<AnnouncementLoginData> callback =
          GeneralCallback<AnnouncementLoginData>(
        onError: (GeneralResponse response) {
          if (isNotLogin) Navigator.of(context, rootNavigator: true).pop();
          ApUtils.showToast(context, response.message);
        },
        onFailure: (DioException dioException) async {
          if (isNotLogin) Navigator.of(context, rootNavigator: true).pop();
          ApUtils.showToast(context, dioException.i18nMessage);
          if (dioException.type == DioExceptionType.badResponse &&
              dioException.response!.statusCode == 403) {
            if (loginType == AnnouncementLoginType.google) {
              await _googleSignIn.signOut();
            }
          }
        },
        onSuccess: (AnnouncementLoginData loginData) {
          this.loginData = loginData;
          this.loginData!.save();
          if (kDebugMode) debugPrint(loginData.key);
          if (isNotLogin) Navigator.of(context, rootNavigator: true).pop();
          if (loginType == AnnouncementLoginType.normal) {
            PreferenceUtil.instance.setStringSecurity(
              ApConstants.announcementPassword,
              _password.text,
            );
          } else {
            PreferenceUtil.instance.setStringSecurity(
              ApConstants.announcementIdToken,
              idToken!,
            );
          }
          ApUtils.showToast(context, ap.loginSuccess);
          PreferenceUtil.instance
              .setBool(ApConstants.announcementIsLogin, true);
          PreferenceUtil.instance.setInt(
            ApConstants.announcementLoginType,
            loginType.index,
          );
          setState(() {
            if (loginData.level != PermissionLevel.user) _getAnnouncements();
            _getApplications();
          });
        },
      );
      debugPrint('$loginType');
      switch (loginType) {
        case AnnouncementLoginType.normal:
          PreferenceUtil.instance.setString(
            ApConstants.announcementUsername,
            _username.text,
          );
          AnnouncementHelper.instance.login(
            username: _username.text,
            password: _password.text,
            callback: callback,
          );
        case AnnouncementLoginType.google:
          try {
            final bool isSignIn = await _googleSignIn.isSignedIn();
            final GoogleSignInAccount? data = isSignIn
                ? await _googleSignIn.signInSilently()
                : await _googleSignIn.signIn();
            if (data != null) {
              final GoogleSignInAuthentication authentication =
                  await data.authentication;
              idToken = authentication.idToken;
              AnnouncementHelper.instance
                  .googleLogin(idToken: idToken, callback: callback);
            } else if (isNotLogin) {
              if (!mounted) return;
              Navigator.of(context, rootNavigator: true).pop();
            }
          } catch (e, s) {
            if (!mounted) return;
            ApUtils.showToast(context, ap.thirdPartyLoginFail);
            CrashlyticsUtils.instance?.recordError(e, s);
            if (isNotLogin) Navigator.of(context, rootNavigator: true).pop();
            if (CrashlyticsUtils.instance != null) rethrow;
          }
        case AnnouncementLoginType.apple:
          try {
            final AuthorizationCredentialAppleID credential =
                await SignInWithApple.getAppleIDCredential(
              scopes: <AppleIDAuthorizationScopes>[
                AppleIDAuthorizationScopes.email,
              ],
            );
            idToken = credential.identityToken;
            AnnouncementHelper.instance
                .appleLogin(idToken: idToken!, callback: callback);
          } catch (e, s) {
            if (!mounted) return;
            ApUtils.showToast(context, ap.thirdPartyLoginFail);
            if (isNotLogin) Navigator.of(context, rootNavigator: true).pop();
            CrashlyticsUtils.instance?.recordError(e, s);
          }
      }
    }
  }
}

extension TagColors on String? {
  Color? get color {
    switch (this) {
      case 'zh':
        return Colors.deepOrange;
      case 'en':
        return Colors.teal;
      case 'nkust':
        return Colors.blue;
      case 'nsysu':
        return Colors.green;
      case 'wtuc':
        return Colors.pink;
      case 'ntust':
        return Colors.blueAccent;
      default:
        return null;
    }
  }
}
