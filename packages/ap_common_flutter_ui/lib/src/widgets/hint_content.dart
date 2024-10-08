import 'package:ap_common_flutter_ui/src/resources/ap_theme.dart';
import 'package:flutter/material.dart';

class HintContent extends StatelessWidget {
  const HintContent({
    required this.icon,
    required this.content,
  });

  final IconData icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Center(
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
              color: ApTheme.of(context).blueAccent,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(color: ApTheme.of(context).grey),
          ),
        ],
      ),
    );
  }
}
