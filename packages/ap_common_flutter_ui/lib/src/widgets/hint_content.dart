import 'package:ap_common_flutter_ui/src/resources/ap_theme.dart';
import 'package:flutter/material.dart';

class HintContent extends StatelessWidget {
  const HintContent({
    required this.icon,
    required this.content,
    this.onTap,
    this.actionText,
  });

  final IconData icon;
  final String content;
  final VoidCallback? onTap;
  final String? actionText;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      liveRegion: true,
      label: content,
      child: Center(
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.vertical,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ApTheme.of(context).dashLine),
                ),
              ),
              child: Icon(
                icon,
                size: 50.0,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            if (onTap != null) ...<Widget>[
              const SizedBox(height: 16.0),
              FilledButton.tonal(
                onPressed: onTap,
                child: Text(actionText ?? content),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
