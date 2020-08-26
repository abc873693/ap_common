import 'package:ap_common/models/notification_data.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:flutter/material.dart';

enum NotificationState { loading, finish, loadingMore, error, empty, offline }

class NotificationScaffold extends StatefulWidget {
  static const String routerName = "/info/notification";
  final NotificationState state;
  final List<Notifications> notificationList;
  final Function onRefresh;
  final Function onLoadingMore;
  final Function() setCurrentScreen;
  final Function(String name, String value) logEvent;

  NotificationScaffold({
    Key key,
    @required this.state,
    @required this.notificationList,
    this.onRefresh,
    this.onLoadingMore,
    this.setCurrentScreen,
    this.logEvent,
  }) : super(key: key);

  @override
  NotificationScaffoldState createState() => NotificationScaffoldState();
}

class NotificationScaffoldState extends State<NotificationScaffold>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ApLocalizations ap;

  ScrollController controller;

  TextStyle get _textStyle => TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      );

  TextStyle get _textGreyStyle => TextStyle(
        color: ApTheme.of(context).grey,
        fontSize: 14.0,
      );

  @override
  void initState() {
    if (widget.setCurrentScreen != null) widget.setCurrentScreen();
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_scrollListener);
  }

  Widget _notificationItem(Notifications notification) {
    return GestureDetector(
      onLongPress: () {
        ApUtils.shareTo("${notification.info.title}\n${notification.link}");
        if (widget.logEvent != null)
          widget.logEvent(
            'share',
            'long_click',
          );
      },
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          ApUtils.launchUrl(notification.link);
          if (widget.logEvent != null)
            widget.logEvent(
              'notification_link',
              'click',
            );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                notification.info.title ?? '',
                style: _textStyle,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      notification.info.department ?? '',
                      style: _textGreyStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      notification.info.date ?? '',
                      style: _textGreyStyle,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ap = ApLocalizations.of(context);
    return _body();
  }

  Widget _body() {
    switch (widget.state) {
      case NotificationState.loading:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case NotificationState.error:
      case NotificationState.empty:
        return FlatButton(
          onPressed: () {
            if (widget.onRefresh != null) widget.onRefresh();
            if (widget.logEvent != null)
              widget.logEvent(
                'rerty',
                'click',
              );
          },
          child: HintContent(
            icon: ApIcon.assignment,
            content: widget.state == NotificationState.error
                ? ap.clickToRetry
                : ap.clickToRetry,
          ),
        );
      case NotificationState.offline:
        return HintContent(
          icon: ApIcon.offlineBolt,
          content: ap.offlineMode,
        );
      default:
        return RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: ListView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              return _notificationItem(widget.notificationList[index]);
            },
            itemCount: widget.notificationList.length,
          ),
        );
    }
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 500) {
      if (widget.state == NotificationState.finish) {
        widget.onLoadingMore();
      }
    }
  }

//  _getNotifications() async {
//    if (Preferences.getBool(Constants.PREF_IS_OFFLINE_LOGIN, false)) {
//      setState(() => widget.state = NotificationState.offline);
//    } else
//      Helper.instance.getNotifications(
//        page: page,
//        callback: GeneralCallback(
//          onSuccess: (NotificationsData data) {
//            for (var notification in data.data.notifications)
//              notificationList.add(notification);
//            if (mounted) setState(() => widget.state = NotificationState.finish);
//          },
//          onFailure: (DioError e) {
//            ApUtils.handleDioError(context, e);
//            if (mounted && notificationList.length == 0)
//              setState(() => widget.state = NotificationState.error);
//          },
//          onError: (GeneralResponse response) {
//            ApUtils.showToast(context, ap.somethingError);
//            if (mounted && notificationList.length == 0)
//              setState(() => widget.state = NotificationState.error);
//          },
//        ),
//      );
//  }
}
