import 'package:ap_common_announcement_ui/src/api/announcement_helper.dart';
import 'package:ap_common_announcement_ui/src/api/imgbb_helper.dart';
import 'package:ap_common_announcement_ui/src/utils/tag_colors.dart';
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
  _AnnouncementEditPageState createState() =>
      _AnnouncementEditPageState();
}

class _AnnouncementEditPageState extends State<AnnouncementEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Announcement announcements;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _imgUrl = TextEditingController();
  final TextEditingController _url = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _reviewDescription =
      TextEditingController();

  DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  DateTime? expireTime;

  List<String> tags = <String>[];

  final TextEditingController _newTag = TextEditingController();

  _ImgurUploadState imgurUploadState = _ImgurUploadState.noFile;

  String get pageTitle {
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

  @override
  void initState() {
    if (widget.mode == Mode.edit ||
        widget.mode == Mode.editApplication) {
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
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: KeyboardDismissOnTap(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              const SizedBox(height: 16),
              _buildTextField(
                controller: _title,
                label: context.ap.title,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 16),
              if (widget.mode != Mode.application) ...<Widget>[
                Text(
                  context.ap.tag,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildTagSection(colorScheme),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _weight,
                  label: context.ap.weight,
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value!.isEmpty) return context.ap.doNotEmpty;
                    try {
                      int.parse(value);
                    } catch (e) {
                      return context.ap.formatError;
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 16),
              _buildTextField(
                controller: _imgUrl,
                label: context.ap.imageUrl,
                enabled: false,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 8),
              _buildImageUploadSection(colorScheme),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _url,
                label: context.ap.url,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),
              Divider(
                color: colorScheme.outlineVariant.withAlpha(77),
              ),
              const SizedBox(height: 8),
              _buildExpireTimeSection(colorScheme),
              const SizedBox(height: 8),
              Divider(
                color: colorScheme.outlineVariant.withAlpha(77),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _description,
                label: context.ap.description,
                maxLines: 5,
              ),
              if (widget.mode ==
                  Mode.editApplication) ...<Widget>[
                const SizedBox(height: 16),
                _buildTextField(
                  controller: TextEditingController(
                    text: announcements.applicant ?? '',
                  ),
                  label: context.ap.applicant,
                  enabled: false,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _reviewDescription,
                  label: context.ap.reviewDescription,
                  maxLines: 2,
                ),
              ],
              const SizedBox(height: 32),
              _buildActionButtons(colorScheme),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool enabled = true,
    int? maxLines,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  Widget _buildTagSection(ColorScheme colorScheme) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: <Widget>[
        for (final String tag in tags)
          Chip(
            label: Text(
              tag,
              style: TextStyle(
                color: tagColor(tag, colorScheme),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            backgroundColor:
                tagColor(tag, colorScheme).withAlpha(26),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            deleteIconColor: tagColor(tag, colorScheme),
            onDeleted: () {
              setState(() => tags.remove(tag));
            },
          ),
        ActionChip(
          label: Icon(
            Icons.add,
            size: 18,
            color: colorScheme.primary,
          ),
          backgroundColor:
              colorScheme.primaryContainer.withAlpha(128),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: _showAddTagDialog,
        ),
      ],
    );
  }

  Widget _buildImageUploadSection(ColorScheme colorScheme) {
    return Column(
      children: <Widget>[
        switch (imgurUploadState) {
          _ImgurUploadState.uploading => Column(
              children: <Widget>[
                const CircularProgressIndicator(),
                const SizedBox(height: 8),
                Text(
                  context.ap.uploading,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          _ImgurUploadState.done => Column(
              children: <Widget>[
                Text(
                  context.ap.imagePreview,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 300,
                    child: ApNetworkImage(url: _imgUrl.text),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          _ImgurUploadState.noFile => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                context.ap.imgurUploadDescription,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
            ),
        },
        FilledButton.tonal(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: _pickAndUploadImage,
          child: Text(context.ap.pickAndUploadToImgur),
        ),
      ],
    );
  }

  Widget _buildExpireTimeSection(ColorScheme colorScheme) {
    return Column(
      children: <Widget>[
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(
              color: colorScheme.outline,
            ),
          ),
          onPressed: () => setState(() => expireTime = null),
          child: Text(context.ap.setNoExpireTime),
        ),
        const SizedBox(height: 8),
        ListTile(
          onTap: _pickStartDateTime,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 8,
          ),
          leading: Icon(
            ApIcon.accessTime,
            size: 24,
            color: colorScheme.onSurfaceVariant,
          ),
          trailing: Icon(
            ApIcon.keyboardArrowDown,
            size: 24,
            color: colorScheme.onSurfaceVariant,
          ),
          title: Text(
            context.ap.expireTime,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            expireTime == null
                ? context.ap.newsExpireTimeHint
                : dateFormat.format(expireTime!),
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ColorScheme colorScheme) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _announcementSubmit,
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        if (widget.mode == Mode.editApplication) ...<Widget>[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () =>
                  _announcementSubmit(isApproval: true),
              child: Text(
                context.ap.updateAndApprove,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.error,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: colorScheme.error),
              ),
              onPressed: () =>
                  _announcementSubmit(isApproval: false),
              child: Text(
                context.ap.updateAndReject,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _announcementSubmit(
                isApproval: false,
                addBlackList: true,
              ),
              child: Text(
                context.ap.updateRejectAndBan,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ],
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) return context.ap.doNotEmpty;
    return null;
  }

  void _showAddTagDialog() {
    _newTag.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) => DefaultDialog(
        title: context.ap.addTag,
        contentWidget: TextField(
          controller: _newTag,
          decoration: InputDecoration(
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
              Navigator.of(context, rootNavigator: true).pop();
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
  }

  Future<void> _pickAndUploadImage() async {
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
    if (result
        case ApiSuccess<Announcement>(:final Announcement data)) {
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
        weight: _weight.text.isNotEmpty
            ? (int.tryParse(_weight.text) ?? 0)
            : 0,
        expireTime:
            (expireTime == null) ? null : expireTime!.parseToString(),
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
          result =
              await AnnouncementHelper.instance.updateAnnouncement(
            data: announcements,
          );
        case Mode.application:
          result = await AnnouncementHelper.instance.addApplication(
            data: announcements,
          );
        case Mode.editApplication:
          result =
              await AnnouncementHelper.instance.updateApplication(
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
          UiUtil.instance
              .showToast(context, context.ap.addSuccess);
        case Mode.edit:
          UiUtil.instance
              .showToast(context, context.ap.updateSuccess);
        case Mode.application:
          UiUtil.instance.showToast(
            context,
            context.ap.applicationSubmitSuccess,
          );
        case Mode.editApplication:
          UiUtil.instance
              .showToast(context, context.ap.updateSuccess);
          if (isApproval != null) {
            final ApiResult<Response<dynamic>> reviewResult;
            if (isApproval) {
              reviewResult = await AnnouncementHelper.instance
                  .approveApplication(
                applicationId: announcements.applicationId,
                reviewDescription:
                    announcements.reviewDescription,
              );
            } else {
              reviewResult = await AnnouncementHelper.instance
                  .rejectApplication(
                applicationId: announcements.applicationId,
                reviewDescription:
                    announcements.reviewDescription,
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
