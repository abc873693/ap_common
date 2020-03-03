import 'package:ap_common/resources/ap_colors.dart';
import 'package:flutter/material.dart';

class Item {
  final String text;
  final String value;

  Item(this.text, this.value);
}

class SettingTitle extends StatelessWidget {
  final String text;

  const SettingTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(
        text,
        style: TextStyle(color: ApColors.blueText, fontSize: 14.0),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class SettingSwitch extends StatelessWidget {
  final String text;
  final String subText;
  final bool value;
  final Function onChanged;

  const SettingSwitch({
    Key key,
    @required this.text,
    @required this.subText,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
      subtitle: Text(
        subText,
        style: TextStyle(fontSize: 14.0, color: ApColors.greyText),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: ApColors.blueAccent,
    );
  }
}

class SettingItem extends StatelessWidget {
  final String text;
  final String subText;
  final Function onTap;

  const SettingItem({
    Key key,
    @required this.text,
    @required this.subText,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
      subtitle: Text(
        subText,
        style: TextStyle(fontSize: 14.0, color: ApColors.greyText),
      ),
      onTap: onTap,
    );
  }
}
