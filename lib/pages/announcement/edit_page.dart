import 'dart:ui';

import 'package:ap_common/api/announcement_helper.dart';
import 'package:ap_common/api/imgur_helper.dart';
import 'package:ap_common/models/announcement_data.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/widgets/ap_network_image.dart';
import 'package:ap_common/widgets/default_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'home_page.dart' show TagColors;

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
  static const String routerName = '/news/edit';

  final Mode mode;
  final Announcement? announcement;
  final bool needFetch;

  const AnnouncementEditPage({
    Key? key,
    required this.mode,
    this.announcement,
    this.needFetch = false,
  }) : super(key: key);

  @override
  _AnnouncementEditPageState createState() => _AnnouncementEditPageState();
}

class _AnnouncementEditPageState extends State<AnnouncementEditPage> {
  final _formKey = GlobalKey<FormState>();

  ApLocalizations get app => ApLocalizations.of(context);

  late Announcement announcements;

  final _title = TextEditingController();
  final _description = TextEditingController();
  final _imgUrl = TextEditingController();
  final _url = TextEditingController();
  final _weight = TextEditingController();
  final _reviewDescription = TextEditingController();

  DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  DateTime? expireTime;

  List<String?>? tags;

  final _newTag = TextEditingController();

  final dividerHeight = 16.0;

  _ImgurUploadState imgurUploadState = _ImgurUploadState.noFile;

  String get title {
    switch (widget.mode) {
      case Mode.add:
      case Mode.edit:
      case Mode.editApplication:
        return app.announcements;
      case Mode.application:
        return app.addApplication;
    }
  }

  String get buttonText {
    switch (widget.mode) {
      case Mode.add:
        return app.submit;
      case Mode.edit:
        return app.update;
      case Mode.editApplication:
      case Mode.application:
        return app.submit;
    }
  }

  List<Widget> get _imgurUploadWidget {
    switch (imgurUploadState) {
      case _ImgurUploadState.uploading:
        return [
          const CircularProgressIndicator(),
          const SizedBox(height: 8.0),
          Text(app.uploading),
        ];
      case _ImgurUploadState.done:
        return [
          Text(app.imagePreview),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 300,
            child: ApNetworkImage(url: _imgUrl.text),
          ),
          const SizedBox(height: 8.0),
        ];
      case _ImgurUploadState.noFile:
      default:
        return [
          Text(app.imgurUploadDescription),
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
      announcements = Announcement();
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
        backgroundColor: ApTheme.of(context).blue,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return app.doNotEmpty;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  fillColor: ApTheme.of(context).blueAccent,
                  labelStyle: TextStyle(
                    color: ApTheme.of(context).grey,
                  ),
                  labelText: app.title,
                ),
              ),
              SizedBox(height: dividerHeight),
              if (widget.mode != Mode.application) ...[
                Text(app.tag),
                Wrap(
                  children: [
                    for (String? tag in tags ?? []) ...[
                      Chip(
                        label: Text(tag!),
                        backgroundColor: tag.color,
                        onDeleted: () {
                          setState(() => tags!.remove(tag));
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
                            title: app.addTag,
                            contentWidget: TextField(
                              controller: _newTag,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: app.tagName,
                              ),
                            ),
                            actionText: ApLocalizations.of(context).confirm,
                            actionFunction: () {
                              if (_newTag.text.isEmpty) {
                                ApUtils.showToast(context, app.doNotEmpty);
                              } else {
                                final newTag = _newTag.text;
                                final index = tags!.indexOf(newTag);
                                if (index == -1) {
                                  setState(() => tags!.add(newTag));
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                } else {
                                  ApUtils.showToast(context, app.tagRepeatHint);
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return app.doNotEmpty;
                    } else {
                      try {
                        int.parse(value);
                      } catch (e) {
                        return app.formatError;
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
                    labelText: app.weight,
                  ),
                ),
              ],
              SizedBox(height: dividerHeight),
              TextFormField(
                controller: _imgUrl,
                enabled: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return app.doNotEmpty;
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
                  labelText: app.imageUrl,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    primary: ApTheme.of(context).blueAccent,
                  ),
                  onPressed: () async {
                    final PickedFile? image = await ApUtils.pickImage();
                    if (image != null) {
                      setState(
                          () => imgurUploadState = _ImgurUploadState.uploading);
                      ImgurHelper.instance!.uploadImageToImgur(
                        file: image,
                        callback: GeneralCallback(
                          onFailure: (dioError) {
                            ApUtils.showToast(context, dioError.message);
                            setState(() => imgurUploadState =
                                _imgUrl.text.isEmpty
                                    ? _ImgurUploadState.noFile
                                    : _ImgurUploadState.done);
                          },
                          onError: (generalResponse) {
                            ApUtils.showToast(context, generalResponse.message);
                            setState(() => imgurUploadState =
                                _imgUrl.text.isEmpty
                                    ? _ImgurUploadState.noFile
                                    : _ImgurUploadState.done);
                          },
                          onSuccess: (data) {
                            _imgUrl.text = data!.link!;
                            setState(() =>
                                imgurUploadState = _ImgurUploadState.done);
                          },
                        ),
                      );
                    }
                  },
                  child: Text(
                    app.pickAndUploadToImgur,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: dividerHeight),
              TextFormField(
                controller: _url,
                validator: (value) {
                  return null;
                },
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  fillColor: ApTheme.of(context).blueAccent,
                  labelStyle: TextStyle(
                    color: ApTheme.of(context).grey,
                  ),
                  labelText: app.url,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    primary: ApTheme.of(context).blueAccent,
                  ),
                  onPressed: () async {
                    setState(() {
                      expireTime = null;
                    });
                  },
                  child: Text(
                    app.setNoExpireTime,
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
                  app.expireTime,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  expireTime == null
                      ? app.newsExpireTimeHint
                      : dateFormat.format(expireTime!),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(color: ApTheme.of(context).grey, height: 1),
              SizedBox(height: dividerHeight),
              TextFormField(
                maxLines: 5,
                controller: _description,
                validator: (value) {
                  return null;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  fillColor: ApTheme.of(context).blueAccent,
                  labelStyle: TextStyle(
                    color: ApTheme.of(context).grey,
                  ),
                  labelText: app.description,
                ),
              ),
              if (widget.mode == Mode.editApplication) ...[
                SizedBox(height: dividerHeight),
                TextFormField(
                  maxLines: 2,
                  controller: _reviewDescription,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: ApTheme.of(context).blueAccent,
                    labelStyle: TextStyle(
                      color: ApTheme.of(context).grey,
                    ),
                    labelText: app.reviewDescription,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    primary: ApTheme.of(context).blueAccent,
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
              if (widget.mode == Mode.editApplication) ...[
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      primary: ApTheme.of(context).yellow,
                    ),
                    onPressed: () {
                      _announcementSubmit(isApproval: true);
                    },
                    child: Text(
                      app.updateAndApprove,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      primary: ApTheme.of(context).red,
                    ),
                    onPressed: () {
                      _announcementSubmit(isApproval: false);
                    },
                    child: Text(
                      app.updateAndReject,
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

  Future _pickStartDateTime() async {
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
    _title.text = announcements.title ?? '';
    _imgUrl.text = announcements.imgUrl ?? '';
    if (announcements.imgUrl != null && announcements.imgUrl!.isNotEmpty) {
      imgurUploadState = _ImgurUploadState.done;
    }
    if (announcements.expireTime != null) {
      expireTime = formatter.parse(announcements.expireTime!);
    }
    _url.text = announcements.url ?? '';
    _weight.text = announcements.weight?.toString() ?? '0';
    _description.text = announcements.description ?? '';
    tags = announcements.tags ?? [];
  }

  void _fetchData() {
    if (widget.mode == Mode.edit) {
      AnnouncementHelper.instance.getAnnouncement(
        id: announcements.id!,
        callback: GeneralCallback.simple(
          context,
          (Announcement data) {
            announcements = data;
            _mapData();
            setState(() {});
          },
        ),
      );
    } else if (widget.mode == Mode.editApplication) {
      AnnouncementHelper.instance.getApplication(
        id: announcements.applicationId!,
        callback: GeneralCallback.simple(
          context,
          (Announcement data) {
            announcements = data;
            _mapData();
            setState(() {});
          },
        ),
      );
    }
  }

  Future<void> _announcementSubmit({bool? isApproval}) async {
    if (_formKey.currentState!.validate()) {
      announcements.title = _title.text;
      announcements.description = _description.text;
      announcements.imgUrl = _imgUrl.text;
      announcements.url = _url.text;
      announcements.weight =
          _weight.text.isNotEmpty ? int.tryParse(_weight.text) : 0;
      announcements.expireTime =
          (expireTime == null) ? null : expireTime!.parseToString();
      announcements.reviewDescription = _reviewDescription.text;
      announcements.tags = tags;
      final callback = GeneralCallback.simple(
        context,
        (Response _) async {
          switch (widget.mode) {
            case Mode.add:
              ApUtils.showToast(context, app.addSuccess);
              break;
            case Mode.edit:
              ApUtils.showToast(context, app.updateSuccess);
              break;
            case Mode.application:
              ApUtils.showToast(context, app.applicationSubmitSuccess);
              break;
            case Mode.editApplication:
              ApUtils.showToast(context, app.updateSuccess);
              if (isApproval != null) {
                if (isApproval) {
                  await AnnouncementHelper.instance.approveApplication(
                    applicationId: announcements.applicationId,
                    reviewDescription: announcements.reviewDescription,
                    callback: GeneralCallback.simple(
                      context,
                      (_) => _,
                    ),
                  );
                } else {
                  await AnnouncementHelper.instance.rejectApplication(
                    applicationId: announcements.applicationId,
                    reviewDescription: announcements.reviewDescription,
                    callback: GeneralCallback.simple(
                      context,
                      (_) => _,
                    ),
                  );
                }
              }
              break;
          }
          Navigator.of(context).pop(true);
        },
      );
      switch (widget.mode) {
        case Mode.add:
          AnnouncementHelper.instance.addAnnouncement(
            data: announcements,
            callback: callback,
          );
          break;
        case Mode.edit:
          AnnouncementHelper.instance.updateAnnouncement(
            data: announcements,
            callback: callback,
          );
          break;
        case Mode.application:
          AnnouncementHelper.instance.addApplication(
            data: announcements,
            callback: callback,
          );
          break;
        case Mode.editApplication:
          AnnouncementHelper.instance.updateApplication(
            data: announcements,
            callback: callback,
          );
          break;
      }
    }
  }
}
