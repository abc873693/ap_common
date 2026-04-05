import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A glass-enhanced version of [ApDrawer].
///
/// Uses [GlassPanel] for the header section while preserving
/// the original menu item structure. Wrapped in a standard
/// [Drawer] since [GlassSideBar] expects navigation items
/// rather than arbitrary widget lists.
class GlassApDrawer extends StatelessWidget {
  const GlassApDrawer({
    super.key,
    required this.onTapHeader,
    required this.widgets,
    this.userInfo,
    this.imageAsset,
    this.imageHeroTag = ApConstants.tagStudentPicture,
    this.displayPicture = false,
  });

  final UserInfo? userInfo;
  final VoidCallback onTapHeader;
  final String? imageAsset;
  final List<Widget> widgets;
  final String imageHeroTag;
  final bool displayPicture;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: const Color(0x00000000),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(20),
        ),
      ),
      child: Material(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            _buildHeader(
              context,
              colorScheme,
              isDark,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                children: widgets,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ColorScheme colorScheme,
    bool isDark,
  ) {
    return GlassPanel(
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? <Color>[
                    colorScheme.primaryContainer
                        .withAlpha(128),
                    colorScheme.surface.withAlpha(128),
                  ]
                : <Color>[
                    colorScheme.primary.withAlpha(128),
                    colorScheme.primaryContainer
                        .withAlpha(128),
                  ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: InkWell(
            onTap: onTapHeader,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: <Widget>[
                  _buildAvatar(
                    context,
                    colorScheme,
                    isDark,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userInfo?.name ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? colorScheme.onSurface
                          : colorScheme.onPrimary,
                    ),
                  ),
                  if (userInfo?.id.isNotEmpty ??
                      false)
                    Text(
                      userInfo!.id,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? colorScheme
                                .onSurfaceVariant
                            : colorScheme.onPrimary
                                .withAlpha(204),
                      ),
                    ),
                  if (userInfo?.department != null)
                    Text(
                      userInfo!.department!,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? colorScheme
                                .onSurfaceVariant
                            : colorScheme.onPrimary
                                .withAlpha(179),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    ColorScheme colorScheme,
    bool isDark,
  ) {
    final bool hasImage =
        displayPicture &&
        userInfo?.pictureBytes != null &&
        userInfo!.pictureBytes!.isNotEmpty;

    return Hero(
      tag: imageHeroTag,
      child: CircleAvatar(
        radius: 36,
        backgroundColor: isDark
            ? colorScheme.primaryContainer
            : colorScheme.onPrimary.withAlpha(51),
        backgroundImage: hasImage
            ? MemoryImage(userInfo!.pictureBytes!)
            : null,
        child: hasImage
            ? null
            : Icon(
                Icons.person_rounded,
                size: 40,
                color: isDark
                    ? colorScheme.primary
                    : colorScheme.onPrimary,
              ),
      ),
    );
  }
}
