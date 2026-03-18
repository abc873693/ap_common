import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

/// 電話列表項目
class PhoneListItem extends StatelessWidget {
  const PhoneListItem({
    super.key,
    required this.phone,
  });

  final PhoneModel phone;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        AnalyticsUtil.instance.logEvent('call_phone_click');
        try {
          PlatformUtil.instance.callPhone(phone.number);
          AnalyticsUtil.instance.logEvent('call_phone_success');
        } catch (e) {
          AnalyticsUtil.instance.logEvent('call_phone_error');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outlineVariant,
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              phone.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8.0),
            Text(
              phone.number,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
