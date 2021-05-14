import 'package:ap_common/models/phone_model.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:flutter/material.dart';

enum PhoneState { loading, finish, error }

class PhoneScaffold extends StatefulWidget {
  static const String routerName = '/info/phone';

  final PhoneState state;
  final List<PhoneModel> phoneModelList;

  const PhoneScaffold({
    Key? key,
    required this.state,
    required this.phoneModelList,
  }) : super(key: key);

  @override
  PhoneScaffoldState createState() => PhoneScaffoldState();
}

class PhoneScaffoldState extends State<PhoneScaffold>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ApLocalizations get ap => ApLocalizations.of(context);

  TextStyle get _textStyle => const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      );

  TextStyle get _textBlueStyle => TextStyle(
        color: ApTheme.of(context).blueText,
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
      'PhoneScaffold',
      'phone_scaffold.dart',
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  Widget _body() {
    switch (widget.state) {
      case PhoneState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case PhoneState.error:
        return HintContent(
          icon: ApIcon.assignment,
          content: ap.clickToRetry,
        );
      default:
        return ListView.builder(
          itemCount: widget.phoneModelList.length,
          itemBuilder: (context, index) {
            if (widget.phoneModelList[index].number.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  widget.phoneModelList[index].name,
                  style: _textBlueStyle,
                  textAlign: TextAlign.left,
                ),
              );
            } else {
              return _phoneItem(widget.phoneModelList[index]);
            }
          },
        );
    }
  }

  Widget _phoneItem(PhoneModel phone) {
    return InkWell(
      onTap: () {
        AnalyticsUtils.instance?.logEvent('call_phone_click');
        try {
          ApUtils.callPhone(phone.number);
          AnalyticsUtils.instance?.logEvent('call_phone_success');
        } catch (e) {
          AnalyticsUtils.instance?.logEvent('call_phone_error');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              phone.name,
              style: _textStyle,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8.0),
            Text(
              phone.number,
              style: _textGreyStyle,
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }
}
