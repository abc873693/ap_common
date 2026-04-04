import 'package:flutter/material.dart';

/// Maps tag names to a stable color from a predefined palette.
///
/// Uses the tag's hash code to pick a color, ensuring the same tag always
/// gets the same color while distributing evenly across the palette.
Color tagColor(String? tag, ColorScheme colorScheme) {
  if (tag == null || tag.isEmpty) return colorScheme.primary;

  const List<Color> palette = <Color>[
    Color(0xFFE57373), // red 300
    Color(0xFFFF8A65), // deepOrange 300
    Color(0xFFFFB74D), // orange 300
    Color(0xFF81C784), // green 300
    Color(0xFF4DB6AC), // teal 300
    Color(0xFF4FC3F7), // lightBlue 300
    Color(0xFF64B5F6), // blue 300
    Color(0xFF9575CD), // deepPurple 300
    Color(0xFFF06292), // pink 300
    Color(0xFFA1887F), // brown 300
  ];

  return palette[tag.hashCode.abs() % palette.length];
}
