import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A single option for [OptionPickerBottomSheet].
///
/// ```dart
/// PickerOption(
///   label: '繁體中文',
///   subtitle: 'Traditional Chinese',
///   icon: Icons.translate_rounded,
/// )
/// ```
class PickerOption {
  const PickerOption({
    required this.label,
    this.subtitle,
    this.icon,
    this.iconBackgroundColor,
  });

  /// Primary display text.
  final String label;

  /// Optional secondary text below the label.
  final String? subtitle;

  /// Optional leading icon.
  final IconData? icon;

  /// Background color for the icon circle.
  /// Defaults to [ColorScheme.primaryContainer].
  final Color? iconBackgroundColor;
}

/// A generic option picker presented as a Material 3
/// bottom sheet.
///
/// Embed the widget for an inline pill button, or call
/// [OptionPickerBottomSheet.show] to open the sheet
/// directly.
///
/// ```dart
/// // As a widget
/// OptionPickerBottomSheet(
///   title: 'Language',
///   options: options,
///   currentIndex: _langIndex,
///   onSelect: (i) => setState(() => _langIndex = i),
/// )
///
/// // Programmatically
/// final int? i = await OptionPickerBottomSheet.show(
///   context: context,
///   title: 'Language',
///   options: options,
/// );
/// ```
class OptionPickerBottomSheet extends StatelessWidget {
  const OptionPickerBottomSheet({
    super.key,
    required this.options,
    required this.title,
    this.titleIcon,
    this.buttonIcon,
    this.onSelect,
    this.currentIndex = 0,
    this.defaultIndex,
    this.defaultLabel,
    this.featureTag,
  });

  /// Items to pick from.
  final List<PickerOption> options;

  /// Title shown in the bottom sheet header.
  final String title;

  /// Icon next to the title. Defaults to a list icon.
  final IconData? titleIcon;

  /// Icon shown in the inline pill button.
  /// When `null` no icon is displayed.
  final IconData? buttonIcon;

  /// Called when the user picks an option.
  final void Function(int index)? onSelect;

  /// Index of the currently selected option.
  final int currentIndex;

  /// Index of the "default" option to badge.
  /// When `null` no badge is shown.
  final int? defaultIndex;

  /// Badge text for [defaultIndex].
  /// For example `'Default'` or `'目前'`.
  final String? defaultLabel;

  /// Analytics feature tag.
  final String? featureTag;

  /// Opens the option picker bottom sheet.
  ///
  /// Returns the selected index, or `null` if the user
  /// dismissed the sheet without picking.
  static Future<int?> show({
    required BuildContext context,
    required List<PickerOption> options,
    required String title,
    IconData? titleIcon,
    int currentIndex = 0,
    int? defaultIndex,
    String? defaultLabel,
  }) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    return showModalBottomSheet<int>(
      context: context,
      backgroundColor: const Color(0x00000000),
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        return DraggableScrollableSheet(
          initialChildSize: _sheetSize(options.length),
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (
            BuildContext context,
            ScrollController scrollController,
          ) {
            return Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius:
                    const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                children: <Widget>[
                  _buildHandle(colorScheme),
                  _buildTitle(
                    title,
                    titleIcon,
                    colorScheme,
                  ),
                  Divider(
                    height: 1,
                    color: colorScheme.outlineVariant
                        .withAlpha(128),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: options.length,
                      itemBuilder: (
                        BuildContext ctx,
                        int index,
                      ) {
                        return _buildItem(
                          context: ctx,
                          option: options[index],
                          index: index,
                          colorScheme: colorScheme,
                          isSelected:
                              index == currentIndex,
                          isDefault:
                              index == defaultIndex,
                          defaultLabel: defaultLabel,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final String displayText =
        options.isNotEmpty &&
                currentIndex < options.length
            ? options[currentIndex].label
            : '';

    return Material(
      color: colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () async {
          if (featureTag != null) {
            // Leave analytics integration to caller
            // via onSelect if needed.
          }
          final int? selected = await show(
            context: context,
            options: options,
            title: title,
            titleIcon: titleIcon,
            currentIndex: currentIndex,
            defaultIndex: defaultIndex,
            defaultLabel: defaultLabel,
          );
          if (selected != null) {
            onSelect?.call(selected);
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (buttonIcon != null) ...<Widget>[
                Icon(
                  buttonIcon,
                  size: 16,
                  color:
                      colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                displayText,
                style: TextStyle(
                  color:
                      colorScheme.onPrimaryContainer,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2),
              Icon(
                Icons.arrow_drop_down_rounded,
                size: 20,
                color:
                    colorScheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────

  /// Pick a reasonable initial height based on the
  /// number of options so short lists don't leave a
  /// huge empty space.
  static double _sheetSize(int count) {
    if (count <= 3) return 0.35;
    if (count <= 6) return 0.5;
    return 0.6;
  }

  static Widget _buildHandle(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  static Widget _buildTitle(
    String title,
    IconData? icon,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, color: colorScheme.primary),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildItem({
    required BuildContext context,
    required PickerOption option,
    required int index,
    required ColorScheme colorScheme,
    required bool isSelected,
    required bool isDefault,
    String? defaultLabel,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.outlineVariant
                  .withAlpha(77),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          Navigator.of(context).pop(index);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: <Widget>[
              if (option.icon != null) ...<Widget>[
                _buildIcon(
                  option: option,
                  colorScheme: colorScheme,
                  isSelected: isSelected,
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: _buildLabel(
                  option: option,
                  colorScheme: colorScheme,
                  isSelected: isSelected,
                  isDefault: isDefault,
                  defaultLabel: defaultLabel,
                ),
              ),
              Icon(
                isSelected
                    ? Icons.check_circle_rounded
                    : Icons.circle_outlined,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.outlineVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildIcon({
    required PickerOption option,
    required ColorScheme colorScheme,
    required bool isSelected,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primary
            : (option.iconBackgroundColor ??
                colorScheme.primaryContainer),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(
          option.icon,
          size: 22,
          color: isSelected
              ? colorScheme.onPrimary
              : colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  static Widget _buildLabel({
    required PickerOption option,
    required ColorScheme colorScheme,
    required bool isSelected,
    required bool isDefault,
    String? defaultLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(
              child: Text(
                option.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isDefault &&
                defaultLabel != null) ...<Widget>[
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary,
                  borderRadius:
                      BorderRadius.circular(4),
                ),
                child: Text(
                  defaultLabel,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onTertiary,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (option.subtitle != null) ...<Widget>[
          const SizedBox(height: 2),
          Text(
            option.subtitle!,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
