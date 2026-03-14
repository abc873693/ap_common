import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

/// 色彩滑桿 Widget，用於 HSV 色彩選擇器
class ColorSlider extends StatelessWidget {
  const ColorSlider({
    super.key,
    required this.label,
    required this.gradientColors,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
  });

  final String label;
  final List<Color> gradientColors;
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 4),
        Container(
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(colors: gradientColors),
          ),
          child: SliderTheme(
            data: const SliderThemeData(
              trackHeight: 24,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
              thumbColor: Color(0xFFFFFFFF),
              overlayColor: Color(0x3DFFFFFF),
              trackShape: RoundedRectSliderTrackShape(),
              activeTrackColor: Color(0x00000000),
              inactiveTrackColor: Color(0x00000000),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

/// 預設色彩選擇圓格
class PresetColorGrid extends StatelessWidget {
  const PresetColorGrid({
    super.key,
    required this.onColorSelected,
  });

  final ValueChanged<Color> onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ApTheme.themeColors.map((ThemeColor themeColor) {
        return GestureDetector(
          onTap: () => onColorSelected(themeColor.color),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: themeColor.color,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFFFFFF),
                width: 2,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: themeColor.color.withAlpha(77),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
