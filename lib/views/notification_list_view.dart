import 'package:ap_common/config/analytics_constants.dart';
import 'package:ap_common/models/notification_data.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:flutter/material.dart';

enum NotificationState { loading, finish, loadingMore, error, empty, offline }

class NotificationListView extends StatefulWidget {
  const NotificationListView({
    Key? key,
    required this.state,
    required this.notificationList,
    required this.onRefresh,
    this.onLoadingMore,
  }) : super(key: key);

  final NotificationState state;
  final List<Notifications> notificationList;
  final Future<void> Function() onRefresh;
  final Future<void> Function()? onLoadingMore;

  @override
  NotificationListViewState createState() => NotificationListViewState();
}

class NotificationListViewState extends State<NotificationListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ApLocalizations get ap => ApLocalizations.of(context);

  ScrollController? controller;

  TextStyle get _textStyle => const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      );

  TextStyle get _textGreyStyle => TextStyle(
        color: ApTheme.of(context).grey,
        fontSize: 14.0,
      );

  @override
  void initState() {
    AnalyticsUtils.instance?.setCurrentScreen(
      'NotificationListView',
      'notification_list_view.dart',
    );
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.removeListener(_scrollListener);
  }

  Widget _notificationItem(Notifications notification) {
    return InkWell(
      onLongPress: () {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        ApUtils.shareTo(
          '${notification.info.title}\n${notification.link}',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
        AnalyticsUtils.instance?.logEvent('share_long_click');
      },
      onTap: () {
        ApUtils.launchUrl(notification.link);
        AnalyticsUtils.instance?.logEvent('notification_link_click');
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              notification.info.title,
              style: _textStyle,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    notification.info.department,
                    style: _textGreyStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    notification.info.date,
                    style: _textGreyStyle,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  Widget _body() {
    switch (widget.state) {
      case NotificationState.loading:
        return Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        );
      case NotificationState.error:
      case NotificationState.empty:
        return InkWell(
          onTap: () {
            widget.onRefresh.call();
            AnalyticsUtils.instance?.logEvent(AnalyticsConstants.refresh);
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
            itemBuilder: (BuildContext context, int index) {
              return _notificationItem(widget.notificationList[index]);
            },
            itemCount: widget.notificationList.length,
          ),
        );
    }
  }

  void _scrollListener() {
    if (controller!.position.extentAfter < 500) {
      if (widget.state == NotificationState.finish) {
        widget.onLoadingMore?.call();
        AnalyticsUtils.instance?.logEvent('notification_load_more');
      }
    }
  }
}
