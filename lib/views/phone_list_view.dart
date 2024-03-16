import 'package:ap_common/models/phone_model.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:flutter/material.dart';

enum PhoneState { loading, finish, error }

class PhoneListView extends StatefulWidget {
  const PhoneListView({
    Key? key,
    required this.state,
    required this.phoneModelList,
  }) : super(key: key);

  final PhoneState state;
  final List<PhoneModel> phoneModelList;

  static const String routerName = '/info/phone';

  @override
  PhoneListViewState createState() => PhoneListViewState();
}

class PhoneListViewState extends State<PhoneListView>
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
      'PhoneListView',
      'phone_list_view.dart',
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
    final Map<PhoneModel?, List<PhoneModel>> phoneGroup =
        <PhoneModel, List<PhoneModel>>{};
    PhoneModel? lastHeader;
    for (int i = 0; i < widget.phoneModelList.length; i++) {
      if (widget.phoneModelList[i].number.isEmpty) {
        phoneGroup[widget.phoneModelList[i]] = <PhoneModel>[];
        lastHeader = widget.phoneModelList[i];
      } else {
        phoneGroup[lastHeader]?.add(widget.phoneModelList[i]);
      }
    }
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
        return CustomScrollView(
          slivers: <Widget>[
            for (final MapEntry<PhoneModel?, List<PhoneModel>> entries
                in phoneGroup.entries)
              SliverMainAxisGroup(
                slivers: <Widget>[
                  if (entries.key != null)
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: HeaderDelegate(entries.key!.name),
                    ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: DecoratedSliver(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.zero,
                      ),
                      sliver: SliverList.separated(
                        itemBuilder: (_, int index) => _phoneItem(
                          entries.value[index],
                        ),
                        separatorBuilder: (_, __) =>
                            const Divider(indent: 8, endIndent: 8),
                        itemCount: entries.value.length,
                      ),
                    ),
                  ),
                ],
              ),
          ],
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
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  const HeaderDelegate(this.title);

  final String title;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: minExtent,
      color: ApTheme.of(context).background,
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: ApTheme.of(context).blueText,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  @override
  double get maxExtent => minExtent;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
