import 'dart:io';

import 'package:ap_common_announcement_ui/src/api/announcement_helper.dart';
import 'package:ap_common_announcement_ui/src/ui/black_list_page.dart';
import 'package:ap_common_announcement_ui/src/ui/edit_page.dart';
import 'package:ap_common_announcement_ui/src/utils/tag_colors.dart';
import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
  _AnnouncementHomePageState createState() =>
      _AnnouncementHomePageState();
}

class _AnnouncementHomePageState extends State<AnnouncementHomePage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _reviewDescription =
      TextEditingController();

  AnnouncementLoginData? loginData;

  DataState<List<Announcement>> announcementState =
      const DataLoading<List<Announcement>>();
  DataState<List<Announcement>> applicationState =
      const DataLoading<List<Announcement>>();

  bool? onlyShowNotReview = false;

  FocusNode? usernameFocusNode;
  FocusNode? passwordFocusNode;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );

  bool get _isLoggedIn => loginData != null;

  bool get _isAdmin =>
      loginData?.level != null &&
      loginData!.level != PermissionLevel.user;

  bool get _isDataLoading =>
      applicationState.isLoading ||
      (_isAdmin && announcementState.isLoading);

  bool get _hasError =>
      applicationState.isError ||
      (_isAdmin && announcementState.isError);

  String _reviewStateText(bool? reviewStatus) {
    if (reviewStatus == null) {
      return context.ap.waitingForReview;
    }
    return reviewStatus
        ? context.ap.reviewApproval
        : context.ap.reviewReject;
  }

  @override
  void initState() {
    Future<dynamic>.microtask(() => _getPreference());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.ap.announcementReviewSystem),
        actions: <Widget>[
          if (_isLoggedIn && _isAdmin) ...<Widget>[
            TextButton(
              onPressed: () {
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
                      setState(() => onlyShowNotReview = value);
                      PreferenceUtil.instance.setBool(
                        ApConstants.announcementOnlyNotReview,
                        onlyShowNotReview!,
                      );
                    },
                  ),
                  Text(
                    context.ap.onlyShowNotReview,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.playlist_remove),
              tooltip: context.ap.blackList,
              onPressed: () {
                ApUtils.pushCupertinoStyle(
                  context,
                  const BlackListPage(),
                );
              },
            ),
          ],
          if (_isLoggedIn)
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: context.ap.logout,
              onPressed: _logout,
            ),
        ],
      ),
      floatingActionButton: !_isAdmin
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
      body: _isLoggedIn
          ? RefreshIndicator(
              onRefresh: () async {
                await _getAnnouncements();
                await _getApplications();
              },
              child: _buildContent(colorScheme),
            )
          : _buildLoginContent(colorScheme),
    );
  }

  Widget _buildContent(ColorScheme colorScheme) {
    if (_isDataLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return InkWell(
        onTap: () {
          _getAnnouncements();
          _getApplications();
        },
        child: HintContent(
          icon: ApIcon.classIcon,
          content: context.ap.clickToRetry,
        ),
      );
    }

    final List<Announcement> apps =
        applicationState.dataOrNull ?? <Announcement>[];
    final List<Announcement> news =
        announcementState.dataOrNull ?? <Announcement>[];

    if (_isAdmin) {
      return _buildAdminView(colorScheme, apps, news);
    }
    return _buildUserView(colorScheme, apps);
  }

  Widget _buildUserView(
    ColorScheme colorScheme,
    List<Announcement> apps,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          widget.reviewDescriptionWidget ??
              SelectableText.rich(
                TextSpan(
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 16.0,
                    height: 1.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${context.ap.newsRuleDescription1(
                        arg1: widget.organizationDomain ?? '',
                      )}\n',
                    ),
                    TextSpan(
                      text: context.ap.newsRuleDescription2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: context.ap.newsRuleDescription3,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
          const SizedBox(height: 24),
          FilledButton.icon(
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
            icon: const Icon(Icons.add),
            label: Text(context.ap.apply),
          ),
          const SizedBox(height: 24),
          Text(
            context.ap.myApplications,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          for (final Announcement item in apps)
            if ((onlyShowNotReview! &&
                    item.reviewStatus == null) ||
                !onlyShowNotReview!)
              _buildItem(
                colorScheme,
                _DataType.application,
                item,
              ),
        ],
      ),
    );
  }

  Widget _buildAdminView(
    ColorScheme colorScheme,
    List<Announcement> apps,
    List<Announcement> news,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Theme(
        data: Theme.of(context)
            .copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16, width: double.infinity),
            Text(
              context.ap.allApplications,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            for (final Announcement item in apps)
              if ((onlyShowNotReview! &&
                      item.reviewStatus == null) ||
                  !onlyShowNotReview!)
                _buildItem(
                  colorScheme,
                  _DataType.application,
                  item,
                ),
            const SizedBox(height: 24),
            Text(
              context.ap.allAnnouncements,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            for (final Announcement item in news)
              _buildItem(
                colorScheme,
                _DataType.announcement,
                item,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginContent(ColorScheme colorScheme) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.loginDescriptionWidget ??
                SelectableText.rich(
                  TextSpan(
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 16.0,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: context.ap.newsRuleDescription1(
                          arg1: widget.organizationDomain ?? '',
                        ),
                      ),
                      TextSpan(
                        text: context.ap.newsRuleDescription3,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
            if (widget.enableNormalLogin) ...<Widget>[
              const SizedBox(height: 16),
              TextField(
                controller: _username,
                textInputAction: TextInputAction.next,
                focusNode: usernameFocusNode,
                onSubmitted: (String text) {
                  usernameFocusNode?.unfocus();
                  FocusScope.of(context)
                      .requestFocus(passwordFocusNode);
                },
                decoration: InputDecoration(
                  labelText: context.ap.account,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                textInputAction: TextInputAction.send,
                controller: _password,
                focusNode: passwordFocusNode,
                onSubmitted: (String text) {
                  passwordFocusNode?.unfocus();
                  _login(AnnouncementLoginType.normal);
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: context.ap.password,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () =>
                      _login(AnnouncementLoginType.normal),
                  child: Text(context.ap.login),
                ),
              ),
            ],
            SizedBox(
              height: widget.enableNormalLogin ? 12.0 : 24.0,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: colorScheme.outline),
                ),
                onPressed: () =>
                    _login(AnnouncementLoginType.google),
                icon: const Icon(Icons.login),
                label: const Text('Sign In with Google'),
              ),
            ),
            if (!kIsWeb &&
                (Platform.isIOS || Platform.isMacOS)) ...<Widget>[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: colorScheme.outline),
                  ),
                  onPressed: () =>
                      _login(AnnouncementLoginType.apple),
                  icon: const Icon(Icons.apple),
                  label: const Text('Sign In with Apple'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    ColorScheme colorScheme,
    _DataType dataType,
    Announcement item,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(77),
        ),
      ),
      child: GestureDetector(
        onLongPress:
            loginData?.level == PermissionLevel.user ||
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
          childrenPadding:
              const EdgeInsets.symmetric(horizontal: 24),
          shape: const RoundedRectangleBorder(),
          title: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          trailing: _buildItemTrailing(
            colorScheme,
            dataType,
            item,
          ),
          subtitle: _buildItemSubtitle(
            colorScheme,
            dataType,
            item,
          ),
          children: <Widget>[
            _buildItemDetails(colorScheme, dataType, item),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget? _buildItemTrailing(
    ColorScheme colorScheme,
    _DataType dataType,
    Announcement item,
  ) {
    if (!_isAdmin || item.reviewStatus != null) return null;

    return IconButton(
      icon: Icon(
        dataType == _DataType.announcement
            ? ApIcon.cancel
            : Icons.approval,
        color: dataType == _DataType.announcement
            ? colorScheme.error
            : colorScheme.tertiary,
      ),
      onPressed: () => _showActionDialog(dataType, item),
    );
  }

  Widget _buildItemSubtitle(
    ColorScheme colorScheme,
    _DataType dataType,
    Announcement item,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (dataType == _DataType.application)
          _buildReviewStatusBadge(colorScheme, item.reviewStatus),
        if (_isAdmin)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: <Widget>[
                for (final String? tag
                    in item.tags ?? <String>[])
                  if (tag != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: tagColor(tag, colorScheme)
                            .withAlpha(26),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: tagColor(tag, colorScheme),
                        ),
                      ),
                    ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildReviewStatusBadge(
    ColorScheme colorScheme,
    bool? reviewStatus,
  ) {
    final Color badgeColor;
    if (reviewStatus == null) {
      badgeColor = colorScheme.tertiary;
    } else if (reviewStatus) {
      badgeColor = colorScheme.primary;
    } else {
      badgeColor = colorScheme.error;
    }

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withAlpha(26),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '${context.ap.reviewState}：${_reviewStateText(reviewStatus)}',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: badgeColor,
        ),
      ),
    );
  }

  Widget _buildItemDetails(
    ColorScheme colorScheme,
    _DataType dataType,
    Announcement item,
  ) {
    final TextStyle labelStyle = TextStyle(
      color: colorScheme.onSurface,
      fontWeight: FontWeight.bold,
      height: 1.5,
      fontSize: 14,
    );
    final TextStyle valueStyle = TextStyle(
      color: colorScheme.onSurfaceVariant,
      height: 1.5,
      fontSize: 14,
    );
    final TextStyle linkStyle = TextStyle(
      color: colorScheme.primary,
      decoration: TextDecoration.underline,
      decorationColor: colorScheme.primary,
      height: 1.5,
      fontSize: 14,
    );

    return SelectableText.rich(
      TextSpan(
        children: <TextSpan>[
          if (_isAdmin) ...<TextSpan>[
            TextSpan(
              text: '${context.ap.weight}：',
              style: labelStyle,
            ),
            TextSpan(
              text: '${item.weight}\n',
              style: valueStyle,
            ),
          ],
          TextSpan(
            text: '${context.ap.imageUrl}：',
            style: labelStyle,
          ),
          TextSpan(
            text: '${item.imgUrl}\n',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () =>
                  PlatformUtil.instance.launchUrl(item.imgUrl),
          ),
          TextSpan(
            text: '${context.ap.url}：',
            style: labelStyle,
          ),
          TextSpan(
            text: '${item.url ?? ""}\n',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (item.url != null) {
                  PlatformUtil.instance.launchUrl(item.url!);
                }
              },
          ),
          TextSpan(
            text: '${context.ap.expireTime}：',
            style: labelStyle,
          ),
          TextSpan(
            text:
                '${item.expireTime ?? context.ap.noExpiration}\n',
            style: valueStyle,
          ),
          TextSpan(
            text: '${context.ap.description}：',
            style: labelStyle,
          ),
          TextSpan(
            text: '${item.description}\n',
            style: valueStyle,
          ),
          TextSpan(
            text: '${context.ap.reviewDescription}：',
            style: labelStyle,
          ),
          TextSpan(
            text: item.reviewDescription ?? '',
            style: valueStyle,
          ),
        ],
      ),
    );
  }

  void _showActionDialog(_DataType dataType, Announcement item) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (_) => dataType == _DataType.announcement
          ? YesNoDialog(
              title: context.ap.deleteNewsTitle,
              contentWidget: Text(
                context.ap.deleteNewsContent,
                textAlign: TextAlign.center,
              ),
              leftActionText: context.ap.determine,
              rightActionText: context.ap.back,
              leftActionFunction: () async {
                final ApiResult<Response<dynamic>> result =
                    await AnnouncementHelper.instance
                        .deleteAnnouncement(data: item);
                _handleResult(result, () {
                  _reviewDescription.text = '';
                  _getAnnouncements();
                });
              },
            )
          : YesNoDialog(
              title: context.ap.reviewApplication,
              contentWidget: TextField(
                controller: _reviewDescription,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: context.ap.reviewDescription,
                  labelStyle: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              leftActionText: context.ap.approve,
              rightActionText: context.ap.reject,
              leftActionFunction: () async {
                final ApiResult<Response<dynamic>> result =
                    await AnnouncementHelper.instance
                        .approveApplication(
                  applicationId: item.applicationId,
                  reviewDescription: _reviewDescription.text,
                );
                _handleResult(result, () {
                  _reviewDescription.text = '';
                  _getAnnouncements();
                  _getApplications();
                });
              },
              rightActionFunction: () async {
                final ApiResult<Response<dynamic>> result =
                    await AnnouncementHelper.instance
                        .rejectApplication(
                  applicationId: item.applicationId,
                  reviewDescription: _reviewDescription.text,
                );
                _handleResult(result, () {
                  _reviewDescription.text = '';
                  _getAnnouncements();
                  _getApplications();
                });
              },
            ),
    );
  }

  void _handleResult(
    ApiResult<dynamic> result,
    VoidCallback onSuccess,
  ) {
    if (result.isSuccess) {
      UiUtil.instance
          .showToast(context, context.ap.updateSuccess);
      onSuccess();
    } else {
      result.showErrorToast(context);
    }
  }

  Future<void> _logout() async {
    if (AnnouncementHelper.instance.loginType ==
        AnnouncementLoginType.google) {
      await _googleSignIn.signOut();
    }
    setState(() {
      PreferenceUtil.instance.setBool(
        ApConstants.announcementIsLogin,
        false,
      );
      loginData = null;
      announcementState =
          const DataLoading<List<Announcement>>();
      applicationState =
          const DataLoading<List<Announcement>>();
    });
  }

  Future<void> _getAnnouncements() async {
    final ApiResult<List<Announcement>> result =
        await AnnouncementHelper.instance.getAllAnnouncements();
    if (!mounted) return;
    switch (result) {
      case ApiSuccess<List<Announcement>>(
            :final List<Announcement> data,
          ):
        setState(() {
          announcementState =
              DataLoaded<List<Announcement>>(data);
        });
      case ApiError<List<Announcement>>():
      case ApiFailure<List<Announcement>>():
        result.showErrorToast(context);
        setState(() {
          announcementState =
              const DataError<List<Announcement>>();
        });
    }
  }

  Future<void> _getApplications() async {
    final ApiResult<List<Announcement>> result =
        await AnnouncementHelper.instance.getApplications();
    if (!mounted) return;
    switch (result) {
      case ApiSuccess<List<Announcement>>(
            :final List<Announcement> data,
          ):
        setState(() {
          applicationState =
              DataLoaded<List<Announcement>>(data);
        });
      case ApiError<List<Announcement>>():
      case ApiFailure<List<Announcement>>():
        result.showErrorToast(context);
        setState(() {
          applicationState =
              const DataError<List<Announcement>>();
        });
    }
  }

  Future<void> _getPreference() async {
    final bool isLogin = PreferenceUtil.instance
        .getBool(ApConstants.announcementIsLogin, false);
    onlyShowNotReview = PreferenceUtil.instance
        .getBool(ApConstants.announcementOnlyNotReview, false);
    _username.text = PreferenceUtil.instance
        .getString(ApConstants.announcementUsername, '');
    _password.text =
        PreferenceUtil.instance.getStringSecurity(
      ApConstants.announcementPassword,
      '',
    );
    if (isLogin) {
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
        AnnouncementHelper.instance
            .setAuthorization(loginData!.key);
        setState(() {
          if (_isAdmin) _getAnnouncements();
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
      UiUtil.instance
          .showToast(context, context.ap.doNotEmpty);
      return;
    }

    final bool isNotLogin = !PreferenceUtil.instance
        .getBool(ApConstants.announcementIsLogin, false);
    if (isNotLogin) {
      showDialog(
        context: context,
        builder: (BuildContext context) => PopScope(
          canPop: false,
          child: ProgressDialog(context.ap.logining),
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

    debugPrint('$loginType');

    ApiResult<AnnouncementLoginData>? result;

    switch (loginType) {
      case AnnouncementLoginType.normal:
        PreferenceUtil.instance.setString(
          ApConstants.announcementUsername,
          _username.text,
        );
        result = await AnnouncementHelper.instance.login(
          username: _username.text,
          password: _password.text,
        );
      case AnnouncementLoginType.google:
        try {
          final bool isSignIn =
              await _googleSignIn.isSignedIn();
          final GoogleSignInAccount? data = isSignIn
              ? await _googleSignIn.signInSilently()
              : await _googleSignIn.signIn();
          if (data != null) {
            final GoogleSignInAuthentication authentication =
                await data.authentication;
            idToken = authentication.idToken;
            result = await AnnouncementHelper.instance
                .googleLogin(idToken: idToken);
          } else if (isNotLogin) {
            if (!mounted) return;
            Navigator.of(context, rootNavigator: true).pop();
            return;
          }
        } catch (e, s) {
          if (!mounted) return;
          UiUtil.instance.showToast(
            context,
            context.ap.thirdPartyLoginFail,
          );
          CrashlyticsUtil.instance.recordError(e, s);
          if (isNotLogin) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          return;
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
          result = await AnnouncementHelper.instance
              .appleLogin(idToken: idToken!);
        } catch (e, s) {
          if (!mounted) return;
          UiUtil.instance.showToast(
            context,
            context.ap.thirdPartyLoginFail,
          );
          if (isNotLogin) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          CrashlyticsUtil.instance.recordError(e, s);
          return;
        }
    }

    if (result == null) return;
    if (!mounted) return;

    switch (result) {
      case ApiSuccess<AnnouncementLoginData>(
            :final AnnouncementLoginData data,
          ):
        loginData = data;
        loginData!.save();
        if (kDebugMode) debugPrint(data.key);
        if (isNotLogin) {
          Navigator.of(context, rootNavigator: true).pop();
        }
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
        UiUtil.instance
            .showToast(context, context.ap.loginSuccess);
        PreferenceUtil.instance
            .setBool(ApConstants.announcementIsLogin, true);
        PreferenceUtil.instance.setInt(
          ApConstants.announcementLoginType,
          loginType.index,
        );
        setState(() {
          if (_isAdmin) _getAnnouncements();
          _getApplications();
        });
      case ApiError<AnnouncementLoginData>(
            :final GeneralResponse response,
          ):
        if (isNotLogin) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        UiUtil.instance
            .showToast(context, response.message);
      case ApiFailure<AnnouncementLoginData>(
            :final DioException exception,
          ):
        if (isNotLogin) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        if (exception.i18nMessage
            case final String message?) {
          UiUtil.instance.showToast(context, message);
        }
        if (exception.type ==
                DioExceptionType.badResponse &&
            exception.response!.statusCode == 403) {
          if (loginType == AnnouncementLoginType.google) {
            await _googleSignIn.signOut();
          }
        }
    }
  }
}
