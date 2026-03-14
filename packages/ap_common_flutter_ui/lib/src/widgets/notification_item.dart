import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

/// 通知列表項目
class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
  });

  final Notifications notification;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onLongPress: () {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        PlatformUtil.instance.shareTo(
          '${notification.info.title}\n${notification.link}',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
        AnalyticsUtil.instance.logEvent('share_long_click');
      },
      onTap: () {
        PlatformUtil.instance.launchUrl(notification.link);
        AnalyticsUtil.instance.logEvent('notification_link_click');
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colorScheme.outlineVariant,
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              notification.info.title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    notification.info.department,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    notification.info.date,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
