import SwiftUI
import WidgetKit

/// Reads the palette the Flutter side pushed via
/// `ApCommonPlugin.setCoursePalette`, falling back to the legacy
/// hardcoded Material 400 palette when no palette has been set yet.
enum CoursePalette {
    private static let keyId = "course_palette_id"
    private static let keyColors = "course_palette_colors"
    private static let keyForeground = "course_palette_foreground"
    private static let keyDarkColors = "course_palette_dark_colors"
    private static let keyDarkForeground = "course_palette_dark_foreground"

    /// Legacy Material 400 palette — matches the previous hardcoded
    /// list so existing installs keep the same visual until the user
    /// opens the app and pushes a new palette.
    private static let legacyColors: [Color] = [
        Color(red: 0.36, green: 0.42, blue: 0.75), // Indigo
        Color(red: 0.15, green: 0.65, blue: 0.60), // Teal
        Color(red: 0.94, green: 0.33, blue: 0.31), // Red
        Color(red: 0.67, green: 0.28, blue: 0.74), // Purple
        Color(red: 0.26, green: 0.65, blue: 0.96), // Blue
        Color(red: 1.00, green: 0.44, blue: 0.26), // Deep Orange
        Color(red: 0.40, green: 0.73, blue: 0.42), // Green
        Color(red: 1.00, green: 0.79, blue: 0.16), // Amber
        Color(red: 0.55, green: 0.43, blue: 0.39), // Brown
        Color(red: 0.47, green: 0.56, blue: 0.61), // Blue Grey
        Color(red: 0.93, green: 0.25, blue: 0.48), // Pink
        Color(red: 0.49, green: 0.34, blue: 0.76), // Deep Purple
    ]

    struct Resolved {
        let colors: [Color]
        let foreground: Color
    }

    /// Resolves the palette for the given [colorScheme], picking dark
    /// variants when available.
    static func resolve(for colorScheme: ColorScheme) -> Resolved {
        guard let groupDefaults = UserDefaults(suiteName: appGroupId) else {
            return Resolved(colors: legacyColors, foreground: .white)
        }
        let isDark = colorScheme == .dark

        let colorsKey = isDark ? keyDarkColors : keyColors
        let foregroundKey = isDark ? keyDarkForeground : keyForeground

        let rawColors = groupDefaults.array(forKey: colorsKey)
            ?? groupDefaults.array(forKey: keyColors)
        let rawForeground = groupDefaults.object(forKey: foregroundKey)
            ?? groupDefaults.object(forKey: keyForeground)

        let colors: [Color]
        if let raw = rawColors as? [Int64], !raw.isEmpty {
            colors = raw.map { argbToColor($0) }
        } else if let raw = rawColors as? [Int], !raw.isEmpty {
            colors = raw.map { argbToColor(Int64($0)) }
        } else if let raw = rawColors as? [NSNumber], !raw.isEmpty {
            colors = raw.map { argbToColor($0.int64Value) }
        } else {
            colors = legacyColors
        }

        let foreground: Color
        if let number = rawForeground as? NSNumber {
            foreground = argbToColor(number.int64Value)
        } else {
            foreground = .white
        }

        return Resolved(colors: colors, foreground: foreground)
    }

    private static func argbToColor(_ argb: Int64) -> Color {
        let alpha = Double((argb >> 24) & 0xFF) / 255.0
        let red = Double((argb >> 16) & 0xFF) / 255.0
        let green = Double((argb >> 8) & 0xFF) / 255.0
        let blue = Double(argb & 0xFF) / 255.0
        return Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
