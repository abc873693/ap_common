import 'package:ap_common_announcement_ui/src/api/announcement_helper.dart';
import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

class BlackListPage extends StatefulWidget {
  const BlackListPage({super.key});

  @override
  State<BlackListPage> createState() => _BlackListPageState();
}

class _BlackListPageState extends State<BlackListPage> {
  DataState<List<String>> state =
      const DataLoading<List<String>>();

  @override
  void initState() {
    Future<dynamic>.microtask(
      () => _getData(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.ap.blackList),
      ),
      body: switch (state) {
        DataLoading<List<String>>() => const Center(
            child: CircularProgressIndicator(),
          ),
        DataError<List<String>>() => InkWell(
            onTap: _getData,
            child: HintContent(
              icon: ApIcon.classIcon,
              content: context.ap.clickToRetry,
            ),
          ),
        DataEmpty<List<String>>() => HintContent(
            icon: ApIcon.classIcon,
            content: context.ap.noData,
          ),
        DataLoaded<List<String>>(:final List<String> data) =>
          ListView.separated(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer
                        .withAlpha(128),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.person_off_outlined,
                    size: 20,
                    color: colorScheme.error,
                  ),
                ),
                title: Text(data[index]),
                trailing: IconButton(
                  onPressed: () => _removeFromBlackList(
                    username: data[index],
                  ),
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: colorScheme.error,
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => Divider(
              height: 1,
              color: colorScheme.outlineVariant.withAlpha(77),
            ),
          ),
      },
    );
  }

  Future<void> _getData() async {
    setState(
      () => state = const DataLoading<List<String>>(),
    );
    final ApiResult<List<String>> result =
        await AnnouncementHelper.instance.getBlackList();
    if (!mounted) return;
    switch (result) {
      case ApiSuccess<List<String>>(:final List<String> data):
        setState(() {
          if (data.isEmpty) {
            state = const DataEmpty<List<String>>();
          } else {
            state = DataLoaded<List<String>>(data);
          }
        });
      case ApiError<List<String>>():
      case ApiFailure<List<String>>():
        result.showErrorToast(context);
        setState(
          () => state = const DataError<List<String>>(),
        );
    }
  }

  Future<void> _removeFromBlackList({
    required String username,
  }) async {
    final ApiResult<Response<dynamic>> result =
        await AnnouncementHelper.instance.removeFromBlackList(
      username: username,
    );
    if (!mounted) return;
    if (result.isSuccess) {
      UiUtil.instance.showToast(
        context,
        context.ap.updateSuccess,
      );
      _getData();
    } else {
      result.showErrorToast(context);
    }
  }
}
