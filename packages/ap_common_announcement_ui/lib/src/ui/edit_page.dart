import 'package:ap_common_announcement_ui/src/api/announcement_helper.dart';
import 'package:ap_common_announcement_ui/src/api/imgbb_helper.dart';
import 'package:ap_common_announcement_ui/src/ui/home_page.dart';
import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

enum _ImgurUploadState { noFile, uploading, done }

enum Mode { add, edit, application, editApplication }

extension ParseDateTimes on DateTime {
  String parseToString() {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final String text = formatter.format(subtract(timeZoneOffset));
    return '${text}Z';
  }
}

class AnnouncementEditPage extends StatefulWidget {
  const AnnouncementEditPage({
    super.key,
    required this.mode,
    this.announcement,
    this.needFetch = false,
  });

  static const String routerName = '/news/edit';

  final Mode mode;
  final Announcement? announcement;
  final bool needFetch;

  @override
  _AnnouncementEditPageState createState() => _AnnouncementEditPageState();
}

class _AnnouncementEditPageState extends State<AnnouncementEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Announcement announcements;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _imgUrl = TextEditingController();
  final TextEditingController _url = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _reviewDescription = TextEditingController();

  DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  DateTime? expireTime;

  List<String> tags = <String>[];

  final TextEditingController _newTag = TextEditingController();

  final double dividerHeight = 16.0;

  _ImgurUploadState imgurUploadState = _ImgurUploadState.noFile;

  String get title {
    switch (widget.mode) {
      case Mode.add:
      case Mode.edit:
      case Mode.editApplication:
        return context.ap.announcements;
      case Mode.application:
        return context.ap.addApplication;
    }
  }

  String get buttonText {
    switch (widget.mode) {
      case Mode.add:
        return context.ap.submit;
      case Mode.edit:
        return context.ap.update;
      case Mode.editApplication:
      case Mode.application:
        return context.ap.submit;
    }
  }

  List<Widget> get _imgurUploadWidget {
    switch (imgurUploadState) {
      case _ImgurUploadState.uploading:
        return <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(height: 8.0),
          Text(context.ap.uploading),
        ];
      case _ImgurUploadState.done:
        return <Widget>[
          Text(context.ap.imagePreview),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 300,
            child: ApNetworkImage(url: _imgUrl.text),
          ),
          const SizedBox(height: 8.0),
        ];
      case _ImgurUploadState.noFile:
        return <Widget>[
          Text(context.ap.imgurUploadDescription),
          const SizedBox(height: 8.0),
        ];
    }
  }

  @override
  void initState() {
    if (widget.mode == Mode.edit || widget.mode == Mode.editApplication) {
      announcements = widget.announcement!;
      _mapData();
      if (widget.needFetch) {
        _fetchData();
      }
    } else {
      announcements = Announcement.empty();
    }
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
        title: Text(title),
      ),
      body: KeyboardDismissOnTap(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              SizedBox(height: dividerHeight),
              TextFormField(
                controller: _title,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return context.ap.doNotEmpty;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  fillColor: ApTheme.of(context).blueAccent,
                  labelStyle: TextStyle(
                    color: ApTheme.of(context).grey,
                  ),
                  labelText: context.ap.title,
                ),
              ),
              SizedBox(height: dividerHeight),
              if (widget.mode != Mode.application) ...<Widget>[
                Text(context.ap.tag),
                Wrap(
                  children: <Widget>[
                    for (final String tag in tags) ...<Widget>[
                      Chip(
                        label: Text(tag),
                        backgroundColor: tag.color,
                        onDeleted: () {
                          setState(() => tags.remove(tag));
                        },
                      ),
                      const SizedBox(width: 8.0),
                    ],
                    GestureDetector(
                      onTap: () {
                        _newTag.clear();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => DefaultDialog(
                            title: context.ap.addTag,
                            contentWidget: TextField(
                              controller: _newTag,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: context.ap.tagName,
                              ),
                            ),
                            actionText: context.ap.confirm,
                            actionFunction: () {
                              if (_newTag.text.isEmpty) {
                                UiUtil.instance
                                    .showToast(context, context.ap.doNotEmpty);
                              } else {
                                final String newTag = _newTag.text;
                                final int index = tags.indexOf(newTag);
                                if (index == -1) {
                                  setState(() => tags.add(newTag));
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                } else {
                                  UiUtil.instance.showToast(
                                    context,
                                    context.ap.tagRepeatHint,
                                  );
                                }
                              }
                            },
                          ),
                        );
                      },
                      child: Chip(
                        label: const Icon(Icons.add),
                        backgroundColor: ApTheme.of(context).blueAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: dividerHeight),
                TextFormField(
                  controller: _weight,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return context.ap.doNotEmpty;
                    } else {
                      try {
                        int.parse(value);
                      } catch (e) {
                        return context.ap.formatError;
                      }
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: ApTheme.of(context).blueAccent,
                    labelStyle: TextStyle(
                      color: ApTheme.of(context).grey,
                    ),
                    labelText: context.ap.weight,
                  ),
                ),
              ],
              SizedBox(height: dividerHeight),
              TextFormField(
                controller: _imgUrl,
                enabled: false,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return context.ap.doNotEmpty;
                  }
                  return null;
                },
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  fillColor: ApTheme.of(context).blueAccent,
                  labelStyle: TextStyle(
                    color: ApTheme.of(context).grey,
                  ),
                  labelText: context.ap.imageUrl,
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Column(
                  children: _imgurUploadWidget,
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    backgroundColor: ApTheme.of(context).blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                  ),
                  onPressed: () async {
                    final XFile? image = await MediaUtil.instance.pickImage();
                    if (image != null) {
                      setState(
                        () => imgurUploadState = _ImgurUploadState.uploading,
                      );
                      final ApiResult<String> result =
                          await ImgbbHelper.instance!.uploadImage(
                        file: image,
                        expireTime: expireTime,
                      );
                      if (!mounted) return;
                      if (result case ApiSuccess<String>(:final String data)) {
                        _imgUrl.text = data;
                        setState(
                          () => imgurUploadState = _ImgurUploadState.done,
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        result.showErrorToast(context);
                        setState(
                          () => imgurUploadState = _imgUrl.text.isEmpty
                              ? _ImgurUploadState.noFile
                              : _ImgurUploadState.done,
                        );
                      }
                    }
                  },
                  child: Text(
                    context.ap.pickAndUploadToImgur,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: dividerHeight),
              TextFormField(
                controller: _url,
                validator: (String? value) {
                  return null;
                },
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  fillColor: ApTheme.of(context).blueAccent,
                  labelStyle: TextStyle(
                    color: ApTheme.of(context).grey,
                  ),
                  labelText: context.ap.url,
                ),
              ),
              SizedBox(height: dividerHeight),
              Container(color: ApTheme.of(context).grey, height: 1),
              const SizedBox(height: 8.0),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    backgroundColor: ApTheme.of(context).blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      expireTime = null;
                    });
                  },
                  child: Text(
                    context.ap.setNoExpireTime,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              ListTile(
                onTap: _pickStartDateTime,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                leading: Icon(
                  ApIcon.accessTime,
                  size: 30,
                  color: ApTheme.of(context).grey,
                ),
                trailing: Icon(
                  ApIcon.keyboardArrowDown,
                  size: 30,
                  color: ApTheme.of(context).grey,
                ),
                title: Text(
                  context.ap.expireTime,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  expireTime == null
                      ? context.ap.newsExpireTimeHint
                      : dateFormat.format(expireTime!),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(color: ApTheme.of(context).grey, height: 1),
              SizedBox(height: dividerHeight),
              TextFormField(
                maxLines: 5,
                controller: _description,
                validator: (String? value) {
                  return null;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  fillColor: ApTheme.of(context).blueAccent,
                  labelStyle: TextStyle(
                    color: ApTheme.of(context).grey,
                  ),
                  labelText: context.ap.description,
                ),
              ),
              if (widget.mode == Mode.editApplication) ...<Widget>[
                SizedBox(height: dividerHeight),
                TextFormField(
                  controller: TextEditingController(
                    text: announcements.applicant ?? '',
                  ),
                  enabled: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: ApTheme.of(context).blueAccent,
                    labelStyle: TextStyle(
                      color: ApTheme.of(context).grey,
                    ),
                    labelText: context.ap.applicant,
                  ),
                ),
                SizedBox(height: dividerHeight),
                TextFormField(
                  maxLines: 2,
                  controller: _reviewDescription,
                  validator: (String? value) {
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: ApTheme.of(context).blueAccent,
                    labelStyle: TextStyle(
                      color: ApTheme.of(context).grey,
                    ),
                    labelText: context.ap.reviewDescription,
                  ),
                ),
              ],
              const SizedBox(height: 36),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    backgroundColor: ApTheme.of(context).blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                  ),
                  onPressed: () {
                    _announcementSubmit();
                  },
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              if (widget.mode == Mode.editApplication) ...<Widget>[
                const SizedBox(height: 18),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      backgroundColor: ApTheme.of(context).yellow,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                    ),
                    onPressed: () {
                      _announcementSubmit(isApproval: true);
                    },
                    child: Text(
                      context.ap.updateAndApprove,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      backgroundColor: ApTheme.of(context).red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                    ),
                    onPressed: () {
                      _announcementSubmit(isApproval: false);
                    },
                    child: Text(
                      context.ap.updateAndReject,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      backgroundColor: ApTheme.of(context).red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                    ),
                    onPressed: () {
                      _announcementSubmit(
                        isApproval: false,
                        addBlackList: true,
                      );
                    },
                    child: Text(
                      context.ap.updateRejectAndBan,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickStartDateTime() async {
    final DateTime dateTime = expireTime ??
        DateTime.now().add(
          const Duration(days: 7),
        );
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1950),
      lastDate: DateTime(2099),
    );
    TimeOfDay? timeOfDay =
        TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    //ignore: use_build_context_synchronously
    if (!mounted) return;
    timeOfDay = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (picked != null && timeOfDay != null) {
      setState(
        () => expireTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          timeOfDay!.hour,
          timeOfDay.minute,
        ),
      );
    }
  }

  void _mapData() {
    _title.text = announcements.title;
    _imgUrl.text = announcements.imgUrl;
    if (announcements.imgUrl.isNotEmpty) {
      imgurUploadState = _ImgurUploadState.done;
    }
    if (announcements.expireTime != null) {
      expireTime = formatter.parse(announcements.expireTime!);
    }
    _url.text = announcements.url ?? '';
    _weight.text = announcements.weight.toString();
    _description.text = announcements.description;
    tags = announcements.tags ?? <String>[];
  }

  Future<void> _fetchData() async {
    final ApiResult<Announcement> result;
    if (widget.mode == Mode.edit) {
      result = await AnnouncementHelper.instance.getAnnouncement(
        id: announcements.id!,
      );
    } else if (widget.mode == Mode.editApplication) {
      result = await AnnouncementHelper.instance.getApplication(
        id: announcements.applicationId!,
      );
    } else {
      return;
    }
    if (!mounted) return;
    if (result case ApiSuccess<Announcement>(:final Announcement data)) {
      announcements = data;
      _mapData();
      setState(() {});
    } else {
      result.showErrorToast(context);
    }
  }

  Future<void> _announcementSubmit({
    bool? isApproval,
    bool? addBlackList,
  }) async {
    if (_formKey.currentState!.validate()) {
      announcements = announcements.copyWith(
        title: _title.text,
        description: _description.text,
        imgUrl: _imgUrl.text,
        url: _url.text,
        weight: _weight.text.isNotEmpty ? (int.tryParse(_weight.text) ?? 0) : 0,
        expireTime: (expireTime == null) ? null : expireTime!.parseToString(),
        reviewDescription: _reviewDescription.text,
        tags: tags,
      );

      final ApiResult<Response<dynamic>> result;
      switch (widget.mode) {
        case Mode.add:
          result = await AnnouncementHelper.instance.addAnnouncement(
            data: announcements,
          );
        case Mode.edit:
          result = await AnnouncementHelper.instance.updateAnnouncement(
            data: announcements,
          );
        case Mode.application:
          result = await AnnouncementHelper.instance.addApplication(
            data: announcements,
          );
        case Mode.editApplication:
          result = await AnnouncementHelper.instance.updateApplication(
            data: announcements,
          );
      }

      if (!mounted) return;
      if (!result.isSuccess) {
        result.showErrorToast(context);
        return;
      }

      switch (widget.mode) {
        case Mode.add:
          UiUtil.instance.showToast(context, context.ap.addSuccess);
        case Mode.edit:
          UiUtil.instance.showToast(context, context.ap.updateSuccess);
        case Mode.application:
          UiUtil.instance
              .showToast(context, context.ap.applicationSubmitSuccess);
        case Mode.editApplication:
          UiUtil.instance.showToast(context, context.ap.updateSuccess);
          if (isApproval != null) {
            final ApiResult<Response<dynamic>> reviewResult;
            if (isApproval) {
              reviewResult =
                  await AnnouncementHelper.instance.approveApplication(
                applicationId: announcements.applicationId,
                reviewDescription: announcements.reviewDescription,
              );
            } else {
              reviewResult =
                  await AnnouncementHelper.instance.rejectApplication(
                applicationId: announcements.applicationId,
                reviewDescription: announcements.reviewDescription,
              );
            }
            if (!mounted) return;
            if (!reviewResult.isSuccess) {
              reviewResult.showErrorToast(context);
              return;
            }
          }
          if (addBlackList ?? false) {
            final ApiResult<Response<dynamic>> banResult =
                await AnnouncementHelper.instance.addBlackList(
              username: announcements.applicant!,
            );
            if (!mounted) return;
            if (!banResult.isSuccess) {
              banResult.showErrorToast(context);
              return;
            }
          }
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
    }
  }
}
