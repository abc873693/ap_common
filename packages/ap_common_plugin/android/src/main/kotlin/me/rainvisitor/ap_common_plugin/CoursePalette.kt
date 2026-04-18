package me.rainvisitor.ap_common_plugin

import android.content.Context
import android.content.res.Configuration
import androidx.compose.ui.graphics.Color

/**
 * Reads the palette the Flutter side pushed via
 * `ApCommonPlugin.setCoursePalette`, falling back to the legacy
 * hardcoded Material 400 palette when nothing has been set yet.
 */
object CoursePalette {
    /** Legacy hardcoded palette — identical to the old hardcoded
     *  `courseColorPalette` that lived inside each widget. Used when
     *  the Flutter app hasn't pushed a palette yet (fresh install). */
    private val legacyColors = listOf(
        Color(0xFF5C6BC0),
        Color(0xFF26A69A),
        Color(0xFFEF5350),
        Color(0xFFAB47BC),
        Color(0xFF42A5F5),
        Color(0xFFFF7043),
        Color(0xFF66BB6A),
        Color(0xFFFFCA28),
        Color(0xFF8D6E63),
        Color(0xFF78909C),
        Color(0xFFEC407A),
        Color(0xFF7E57C2),
    )

    data class Resolved(
        val colors: List<Color>,
        val foreground: Color,
    )

    fun resolve(context: Context): Resolved {
        val prefs = context.getSharedPreferences(
            ApCommonPlugin.PREF_NAME,
            Context.MODE_PRIVATE,
        )
        val isDark =
            (context.resources.configuration.uiMode and
                Configuration.UI_MODE_NIGHT_MASK) ==
                Configuration.UI_MODE_NIGHT_YES

        val colorsKey =
            if (isDark)
                ApCommonPlugin.KEY_COURSE_PALETTE_DARK_COLORS
            else
                ApCommonPlugin.KEY_COURSE_PALETTE_COLORS
        val foregroundKey =
            if (isDark)
                ApCommonPlugin.KEY_COURSE_PALETTE_DARK_FOREGROUND
            else
                ApCommonPlugin.KEY_COURSE_PALETTE_FOREGROUND

        // Fall back to the light variant if dark hasn't been pushed.
        val rawColors = prefs.getString(colorsKey, null)
            ?: prefs.getString(
                ApCommonPlugin.KEY_COURSE_PALETTE_COLORS,
                null,
            )
        val rawForeground = prefs.getLong(foregroundKey, Long.MIN_VALUE)
            .takeIf { it != Long.MIN_VALUE }
            ?: prefs.getLong(
                ApCommonPlugin.KEY_COURSE_PALETTE_FOREGROUND,
                Long.MIN_VALUE,
            )

        val colors = rawColors
            ?.split(",")
            ?.mapNotNull { it.trim().toLongOrNull()?.let(::argbToColor) }
            ?.takeIf { it.isNotEmpty() }
            ?: legacyColors
        val foreground =
            if (rawForeground != Long.MIN_VALUE) argbToColor(rawForeground)
            else Color.White

        return Resolved(colors = colors, foreground = foreground)
    }

    private fun argbToColor(argb: Long): Color {
        val alpha = ((argb shr 24) and 0xFF).toInt()
        val red = ((argb shr 16) and 0xFF).toInt()
        val green = ((argb shr 8) and 0xFF).toInt()
        val blue = (argb and 0xFF).toInt()
        return Color(red = red, green = green, blue = blue, alpha = alpha)
    }
}
