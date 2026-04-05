package me.rainvisitor.ap_common_plugin

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.width
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import androidx.glance.action.actionStartActivity
import androidx.glance.action.clickable
import androidx.glance.appwidget.action.actionRunCallback
import androidx.glance.ImageProvider
import androidx.glance.Image
import androidx.glance.layout.size
import kotlinx.serialization.json.Json
import java.util.*

/**
 * A full weekly course table widget rendered using Jetpack Glance.
 *
 * Displays a grid with weekdays as columns and time slots as rows,
 * matching the Flutter course table style.
 */
class CourseTableWidget : GlanceAppWidget() {
    companion object {
        private val json = Json { ignoreUnknownKeys = true }

        // Course palette matching Flutter's courseColors
        private val courseColorPalette = listOf(
            Color(0xFF5C6BC0), // Indigo
            Color(0xFF26A69A), // Teal
            Color(0xFFEF5350), // Red
            Color(0xFFAB47BC), // Purple
            Color(0xFF42A5F5), // Blue
            Color(0xFFFF7043), // Deep Orange
            Color(0xFF66BB6A), // Green
            Color(0xFFFFCA28), // Amber
            Color(0xFF8D6E63), // Brown
            Color(0xFF78909C), // Blue Grey
            Color(0xFFEC407A), // Pink
            Color(0xFF7E57C2), // Deep Purple
        )

        private val headerBackground = androidx.glance.color.ColorProvider(
            day = Color(0xFF2673FF),
            night = Color(0xFF1A1C2E),
        )
        private val surfaceBackground = androidx.glance.color.ColorProvider(
            day = Color(0xFFF8F9FA),
            night = Color(0xFF121212),
        )
        private val headerTextColor = androidx.glance.color.ColorProvider(
            day = Color.White,
            night = Color(0xFFE0E0E0),
        )
        private val gridLineColor = androidx.glance.color.ColorProvider(
            day = Color(0xFFE0E0E0),
            night = Color(0xFF2C2C2C),
        )
        private val emptyTextColor = androidx.glance.color.ColorProvider(
            day = Color(0xFF9E9E9E),
            night = Color(0xFF616161),
        )
        private val timeTextColor = androidx.glance.color.ColorProvider(
            day = Color(0xFF757575),
            night = Color(0xFF9E9E9E),
        )

        private const val CELL_HEIGHT = 44
        private const val HEADER_HEIGHT = 28
        private const val TIME_COL_WIDTH = 32
    }

    override suspend fun provideGlance(
        context: Context,
        id: GlanceId
    ) {
        val courseData = loadCourseData(context)
        provideContent {
            GlanceTheme {
                CourseTableContent(context, courseData)
            }
        }
    }

    @Composable
    private fun CourseTableContent(context: Context, data: CourseData?) {
        val launchIntent = context.packageManager
            .getLaunchIntentForPackage(context.packageName)

        Column(
            modifier = GlanceModifier.fillMaxSize()
                .background(surfaceBackground)
                .cornerRadius(16.dp)
                .then(
                    if (launchIntent?.component != null) {
                        GlanceModifier.clickable(
                            actionStartActivity(launchIntent.component!!)
                        )
                    } else {
                        GlanceModifier
                    }
                ),
        ) {
            // Title bar
            TitleBar(context)

            if (data == null || data.courses.isEmpty()) {
                // Empty state
                Box(
                    modifier = GlanceModifier.fillMaxSize(),
                    contentAlignment = Alignment.Center,
                ) {
                    Text(
                        text = context.getString(R.string.not_load_course_table),
                        style = TextStyle(
                            color = emptyTextColor,
                            fontSize = 14.sp,
                            textAlign = TextAlign.Center,
                        ),
                    )
                }
            } else {
                CourseGrid(context, data)
            }
        }
    }

    @Composable
    private fun TitleBar(context: Context) {
        Row(
            modifier = GlanceModifier.fillMaxWidth()
                .height(HEADER_HEIGHT.dp)
                .background(headerBackground),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Box(
                modifier = GlanceModifier.defaultWeight()
                    .padding(start = 12.dp),
                contentAlignment = Alignment.CenterStart,
            ) {
                Text(
                    text = context.getString(R.string.course_table),
                    style = TextStyle(
                        color = headerTextColor,
                        fontSize = 13.sp,
                        fontWeight = FontWeight.Bold,
                    ),
                )
            }
            Image(
                provider = ImageProvider(R.drawable.ic_refresh),
                contentDescription = "Refresh",
                modifier = GlanceModifier
                    .size(HEADER_HEIGHT.dp)
                    .padding(4.dp)
                    .clickable(
                        actionRunCallback<RefreshTableAction>()
                    ),
            )
        }
    }

    @Composable
    private fun CourseGrid(context: Context, data: CourseData) {
        val hasHoliday = data.courses.any { course ->
            course.times.any { it.weekday >= 6 }
        }
        val weekdayCount = if (hasHoliday) 7 else 5

        val weekdayLabels = context.resources.getStringArray(
            R.array.weekday_labels
        )

        // Find time range
        var minIndex = Int.MAX_VALUE
        var maxIndex = 0
        for (course in data.courses) {
            for (t in course.times) {
                if (t.index < minIndex) minIndex = t.index
                if (t.index > maxIndex) maxIndex = t.index
            }
        }
        if (minIndex > maxIndex) {
            minIndex = 0
            maxIndex = 0
        }

        // Build lookup: weekday (1-7) → timeIndex → Course
        val lookup = mutableMapOf<Int, MutableMap<Int, Course>>()
        val colorMap = mutableMapOf<String, Color>()
        var colorIdx = 0
        for (course in data.courses) {
            if (course.code !in colorMap) {
                colorMap[course.code] =
                    courseColorPalette[colorIdx % courseColorPalette.size]
                colorIdx++
            }
            for (t in course.times) {
                lookup.getOrPut(t.weekday) { mutableMapOf() }[t.index] =
                    course
            }
        }

        Column(modifier = GlanceModifier.fillMaxSize().padding(4.dp)) {
            // Weekday header row
            Row(modifier = GlanceModifier.fillMaxWidth()) {
                // Time column header (empty corner)
                Box(
                    modifier = GlanceModifier
                        .width(TIME_COL_WIDTH.dp)
                        .height(20.dp),
                )
                for (d in 1..weekdayCount) {
                    Box(
                        modifier = GlanceModifier
                            .defaultWeight()
                            .height(20.dp),
                        contentAlignment = Alignment.Center,
                    ) {
                        val today = getTodayWeekday()
                        val isToday = d == today
                        Text(
                            text = weekdayLabels.getOrElse(d - 1) { "" },
                            style = TextStyle(
                                color = if (isToday) {
                                    ColorProvider(
                                        Color(0xFF2673FF)
                                    )
                                } else {
                                    timeTextColor
                                },
                                fontSize = 10.sp,
                                fontWeight = if (isToday) {
                                    FontWeight.Bold
                                } else {
                                    FontWeight.Normal
                                },
                            ),
                        )
                    }
                }
            }

            // Time slot rows
            for (t in minIndex..maxIndex) {
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    // Time label column
                    Box(
                        modifier = GlanceModifier
                            .width(TIME_COL_WIDTH.dp)
                            .height(CELL_HEIGHT.dp),
                        contentAlignment = Alignment.Center,
                    ) {
                        val timeCode = data.timeCodes.getOrNull(t)
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally,
                        ) {
                            Text(
                                text = timeCode?.title ?: "$t",
                                style = TextStyle(
                                    color = timeTextColor,
                                    fontSize = 10.sp,
                                    fontWeight = FontWeight.Medium,
                                ),
                            )
                            if (timeCode != null) {
                                Text(
                                    text = timeCode.startTime,
                                    style = TextStyle(
                                        color = timeTextColor,
                                        fontSize = 7.sp,
                                    ),
                                )
                            }
                        }
                    }

                    // Course cells
                    for (d in 1..weekdayCount) {
                        val course = lookup[d]?.get(t)
                        Box(
                            modifier = GlanceModifier
                                .defaultWeight()
                                .height(CELL_HEIGHT.dp)
                                .padding(1.dp),
                            contentAlignment = Alignment.Center,
                        ) {
                            if (course != null) {
                                CourseCell(
                                    course = course,
                                    color = colorMap[course.code]
                                        ?: courseColorPalette[0],
                                )
                            }
                        }
                    }
                }
            }
        }
    }

    @Composable
    private fun CourseCell(course: Course, color: Color) {
        Box(
            modifier = GlanceModifier
                .fillMaxSize()
                .cornerRadius(6.dp)
                .background(color),
            contentAlignment = Alignment.Center,
        ) {
            Column(
                modifier = GlanceModifier.padding(2.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
            ) {
                Text(
                    text = if (course.title.length > 4) {
                        course.title.take(4)
                    } else {
                        course.title
                    },
                    style = TextStyle(
                        color = ColorProvider(Color.White),
                        fontSize = 9.sp,
                        fontWeight = FontWeight.Bold,
                        textAlign = TextAlign.Center,
                    ),
                    maxLines = 2,
                )
                val loc = course.location?.displayText
                if (!loc.isNullOrEmpty()) {
                    Text(
                        text = loc,
                        style = TextStyle(
                            color = ColorProvider(
                                Color.White.copy(alpha = 0.8f)
                            ),
                            fontSize = 7.sp,
                            textAlign = TextAlign.Center,
                        ),
                        maxLines = 1,
                    )
                }
            }
        }
    }

    private fun loadCourseData(context: Context): CourseData? {
        val preference = context.getSharedPreferences(
            ApCommonPlugin.PREF_NAME,
            Context.MODE_PRIVATE,
        )
        val rawData = preference.getString(
            ApCommonPlugin.KEY_COURSE_NOTIFY, ""
        )
        if (rawData.isNullOrEmpty()) return null
        return try {
            json.decodeFromString<CourseData>(rawData)
        } catch (e: Exception) {
            null
        }
    }

    private fun getTodayWeekday(): Int {
        val cal = Calendar.getInstance()
        val raw = cal.get(Calendar.DAY_OF_WEEK)
        return if (raw == Calendar.SUNDAY) 7 else raw - 1
    }
}
