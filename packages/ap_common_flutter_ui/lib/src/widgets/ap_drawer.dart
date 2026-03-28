import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:ap_common_flutter_ui/src/resources/ap_theme.dart';
import 'package:flutter/material.dart';

class ApDrawer extends StatelessWidget {
  const ApDrawer({
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: Color(0x00000000),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: Material(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            _buildHeader(context, colorScheme, isDark),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? <Color>[
                  colorScheme.primaryContainer,
                  colorScheme.surface,
                ]
              : <Color>[
                  colorScheme.primary,
                  colorScheme.primaryContainer,
                ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: InkWell(
          onTap: onTapHeader,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildAvatar(context, colorScheme, isDark),
                    const SizedBox(height: 16),
                    _buildUserInfo(context, colorScheme, isDark),
                  ],
                ),
                if (imageAsset != null)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Opacity(
                      opacity: ApTheme.of(context).drawerIconOpacity,
                      child: Image.asset(
                        imageAsset!,
                        width: 90.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(
      BuildContext context, ColorScheme colorScheme, bool isDark) {
    final bool hasImage = displayPicture &&
        userInfo?.pictureBytes != null &&
        userInfo!.pictureBytes!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark
              ? colorScheme.primary
              : colorScheme.onPrimary.withAlpha(128),
          width: 3,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorScheme.shadow.withAlpha(51),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Hero(
        tag: imageHeroTag,
        child: CircleAvatar(
          radius: 36,
          backgroundColor: isDark
              ? colorScheme.primaryContainer
              : colorScheme.onPrimary.withAlpha(51),
          backgroundImage:
              hasImage ? MemoryImage(userInfo!.pictureBytes!) : null,
          child: hasImage
              ? null
              : Icon(
                  ApIcon.accountCircle,
                  size: 40,
                  color: isDark ? colorScheme.primary : colorScheme.onPrimary,
                ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(
      BuildContext context, ColorScheme colorScheme, bool isDark) {
    final Color textColor =
        isDark ? colorScheme.onSurface : colorScheme.onPrimary;
    final Color subtitleColor = isDark
        ? colorScheme.onSurfaceVariant
        : colorScheme.onPrimary.withAlpha(217);

    if (userInfo == null) {
      return Text(
        ap.notLogin,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    final String name = userInfo!.name ?? '';
    final String id = userInfo!.id;
    final String department = userInfo!.department ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          id,
          style: TextStyle(
            color: subtitleColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (department.isNotEmpty) ...<Widget>[
          const SizedBox(height: 2),
          Text(
            department,
            style: TextStyle(
              color: subtitleColor.withAlpha(230),
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.selected = false,
    this.enabled = true,
    this.isExternalLink = false,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool selected;
  final bool enabled;
  final bool isExternalLink;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color disabledColor = colorScheme.onSurface.withAlpha(97);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: selected
            ? colorScheme.primaryContainer.withAlpha(128)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 24,
                  color: enabled
                      ? (iconColor ??
                          (selected
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant))
                      : disabledColor,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                      color: enabled
                          ? (selected
                              ? colorScheme.primary
                              : colorScheme.onSurface)
                          : disabledColor,
                    ),
                  ),
                ),
                if (!enabled)
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 16,
                    color: disabledColor,
                  )
                else if (isExternalLink)
                  Icon(
                    Icons.open_in_new_rounded,
                    size: 16,
                    color: colorScheme.onSurfaceVariant.withAlpha(128),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerMenuSection extends StatelessWidget {
  const DrawerMenuSection({
    super.key,
    required this.icon,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    this.enabled = true,
    this.onExpansionChanged,
  });

  final IconData icon;
  final String title;
  final List<DrawerSubMenuItem> children;
  final bool initiallyExpanded;
  final bool enabled;
  final ValueChanged<bool>? onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color disabledColor = colorScheme.onSurface.withAlpha(97);

    if (!enabled) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Material(
          color: Color(0x00000000),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              children: <Widget>[
                Icon(icon, size: 24, color: disabledColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: disabledColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.lock_outline_rounded,
                  size: 16,
                  color: disabledColor,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Color(0x00000000),
          splashColor: colorScheme.primary.withAlpha(26),
        ),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          onExpansionChanged: onExpansionChanged,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: colorScheme.primaryContainer.withAlpha(38),
          collapsedBackgroundColor: colorScheme.surface,
          leading: Icon(
            icon,
            size: 24,
            color: initiallyExpanded
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: initiallyExpanded ? FontWeight.w600 : FontWeight.w500,
              color: initiallyExpanded
                  ? colorScheme.primary
                  : colorScheme.onSurface,
            ),
          ),
          trailing: AnimatedRotation(
            turns: initiallyExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: initiallyExpanded
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Column(children: children),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerSubMenuItem extends StatelessWidget {
  const DrawerSubMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color disabledColor = colorScheme.onSurface.withAlpha(97);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Material(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: enabled
                        ? colorScheme.primaryContainer.withAlpha(102)
                        : colorScheme.surfaceContainerHighest.withAlpha(128),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: enabled ? colorScheme.primary : disabledColor,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: enabled
                          ? colorScheme.onSurface.withAlpha(217)
                          : disabledColor,
                    ),
                  ),
                ),
                Icon(
                  enabled
                      ? Icons.chevron_right_rounded
                      : Icons.lock_outline_rounded,
                  size: enabled ? 20 : 16,
                  color: enabled
                      ? colorScheme.onSurfaceVariant.withAlpha(128)
                      : disabledColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerDivider extends StatelessWidget {
  const DrawerDivider({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    if (label != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Text(
          label!,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant.withAlpha(179),
            letterSpacing: 1.2,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Divider(
        height: 1,
        color: colorScheme.outlineVariant.withAlpha(128),
      ),
    );
  }
}

// Keep the old class names as aliases for backward compatibility if needed,
// or simply replace them if the breakage is acceptable.
// Given this is a UI package, we should try to keep DrawerItem
// and DrawerSubItem.
typedef DrawerItem = DrawerMenuItem;
typedef DrawerSubItem = DrawerSubMenuItem;
