import 'package:ap_common_announcement_ui/src/api/announcement_helper.dart';
import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

enum _State { loading, done, error }

class BlackListPage extends StatefulWidget {
  const BlackListPage({super.key});

  @override
  State<BlackListPage> createState() => _BlackListPageState();
}

class _BlackListPageState extends State<BlackListPage> {
  _State state = _State.loading;
  List<String> blackList = <String>[];

  @override
  void initState() {
    Future<dynamic>.microtask(
      () => _getData(),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.ap.blackList),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    switch (state) {
      case _State.loading:
        return Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        );
      case _State.error:
        return InkWell(
          onTap: () {
            _getData();
          },
          child: HintContent(
            icon: ApIcon.classIcon,
            content: context.ap.clickToRetry,
          ),
        );
      case _State.done:
        return ListView.separated(
          itemCount: blackList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(blackList[index]),
              trailing: IconButton(
                onPressed: () =>
                    _removeFromBlackList(username: blackList[index]),
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: ApTheme.of(context).red,
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const Divider(),
        );
    }
  }

  Future<void> _getData() async {
    setState(() => state = _State.loading);
    final ApiResult<List<String>> result =
        await AnnouncementHelper.instance.getBlackList();
    switch (result) {
      case ApiSuccess<List<String>>(:final data):
        blackList = data;
        setState(() => state = _State.done);
      case ApiFailure<List<String>>(:final exception):
        Toast.show(exception.i18nMessage, context);
        setState(() => state = _State.error);
      case ApiError<List<String>>(:final response):
        Toast.show(response.message, context);
        setState(() => state = _State.error);
    }
  }

  Future<void> _removeFromBlackList({
    required String username,
  }) async {
    setState(() => state = _State.loading);
    final ApiResult<Response<dynamic>> result =
        await AnnouncementHelper.instance.removeFromBlackList(
      username: username,
    );
    switch (result) {
      case ApiSuccess<Response<dynamic>>():
        Toast.show(context.ap.updateSuccess, context);
        setState(() => state = _State.done);
      case ApiFailure<Response<dynamic>>(:final exception):
        Toast.show(exception.i18nMessage, context);
        setState(() => state = _State.done);
      case ApiError<Response<dynamic>>(:final response):
        Toast.show(response.message, context);
        setState(() => state = _State.done);
    }
  }
}
