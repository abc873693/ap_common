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
import androidx.glance.appwidget.lazy.LazyColumn
import androidx.glance.appwidget.lazy.items
import androidx.glance.appwidget.lazy.itemsIndexed
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
        Box(
            modifier = GlanceModifier.fillMaxWidth()
                .height(HEADER_HEIGHT.dp)
                .background(headerBackground),
            contentAlignment = Alignment.Center,
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
    }

    @Composable
    private fun CourseGrid(context: Context, data: CourseData) {
        val palette = CoursePalette.resolve(context).colors
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
        for (course in data.courses) {
            for (t in course.times) {
                lookup.getOrPut(t.weekday) { mutableMapOf() }[t.index] =
                    course
            }
        }

        // Assign colors by grid scan order (weekday → timeIndex)
        // to match Flutter's _getCourseColor iteration order.
        val colorMap = mutableMapOf<String, Color>()
        var colorIdx = 0
        for (d in 1..weekdayCount) {
            val dayMap = lookup[d] ?: continue
            for (t in minIndex..maxIndex) {
                val course = dayMap[t] ?: continue
                if (course.code !in colorMap) {
                    colorMap[course.code] =
                        palette[colorIdx % palette.size]
                    colorIdx++
                }
            }
        }

        // Pre-compute span info for merging consecutive same-course slots.
        // spanStart[weekday][timeIndex] = span length (only at the first slot)
        val spanStart = mutableMapOf<Int, MutableMap<Int, Int>>()
        for (d in 1..weekdayCount) {
            val dayMap = lookup[d] ?: continue
            val starts = mutableMapOf<Int, Int>()
            var t = minIndex
            while (t <= maxIndex) {
                val course = dayMap[t]
                if (course != null) {
                    var span = 1
                    while (t + span <= maxIndex &&
                        dayMap[t + span]?.code == course.code
                    ) {
                        span++
                    }
                    starts[t] = span
                    t += span
                } else {
                    t++
                }
            }
            spanStart[d] = starts
        }

        LazyColumn(modifier = GlanceModifier.fillMaxSize().padding(4.dp)) {
            // Weekday header row
            item {
                Row(modifier = GlanceModifier.fillMaxWidth()) {
                    // Time column header (empty corner)
                    Box(
                        modifier = GlanceModifier
                            .width(TIME_COL_WIDTH.dp)
                            .height(20.dp),
                    ) {}
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
            }

            // Time slot rows
            items(maxIndex - minIndex + 1) { index ->
                val t = minIndex + index
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
                        val color = colorMap[course?.code]
                            ?: palette[0]
                        val daySpans = spanStart[d]
                        val span = daySpans?.get(t) // non-null = first slot
                        // Determine position within a merged span
                        val isFirst = span != null
                        val isContinuation = !isFirst && course != null
                        // Check if next slot continues this course
                        val nextContinues = course != null &&
                            lookup[d]?.get(t + 1)?.code == course.code &&
                            daySpans?.get(t + 1) == null
                        // isLast = continuation slot where next does not continue
                        val isLast = isContinuation && !nextContinues

                        val topPad = if (isContinuation) 0.dp else 1.dp
                        val bottomPad = when {
                            isFirst && span!! > 1 -> 0.dp
                            isContinuation && !isLast -> 0.dp
                            else -> 1.dp
                        }

                        Box(
                            modifier = GlanceModifier
                                .defaultWeight()
                                .height(CELL_HEIGHT.dp)
                                .padding(
                                    start = 1.dp,
                                    end = 1.dp,
                                    top = topPad,
                                    bottom = bottomPad,
                                ),
                            contentAlignment = Alignment.Center,
                        ) {
                            val isSingle = isFirst && span == 1
                            val isSpanFirst = isFirst && span!! > 1
                            when {
                                isSingle -> CourseCell(
                                    course = course!!,
                                    color = color,
                                    span = 1,
                                    roundTop = true,
                                    roundBottom = true,
                                )
                                isSpanFirst -> CourseCell(
                                    course = course!!,
                                    color = color,
                                    span = span!!,
                                    roundTop = true,
                                    roundBottom = false,
                                )
                                isLast -> CourseCellContinuation(
                                    color = color,
                                    roundBottom = true,
                                )
                                isContinuation -> CourseCellContinuation(
                                    color = color,
                                    roundBottom = false,
                                )
                            }
                        }
                    }
                }
            }
        }
    }

    /**
     * Renders a course cell with selective rounded corners.
     *
     * Glance only supports [cornerRadius] on all 4 corners.
     * To simulate per-corner rounding we layer a rounded box
     * behind a half-height plain rectangle that covers the
     * corners we want flat.
     */
    @Composable
    private fun CourseCell(
        course: Course,
        color: Color,
        span: Int,
        roundTop: Boolean,
        roundBottom: Boolean,
    ) {
        Box(modifier = GlanceModifier.fillMaxSize()) {
            // Background layers
            RoundedCellBackground(
                color = color,
                roundTop = roundTop,
                roundBottom = roundBottom,
            )
            // Content
            Box(
                modifier = GlanceModifier.fillMaxSize(),
                contentAlignment = Alignment.Center,
            ) {
                Column(
                    modifier = GlanceModifier.padding(2.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                ) {
                    val maxChars = if (span > 1) 8 else 4
                    Text(
                        text = if (course.title.length > maxChars) {
                            course.title.take(maxChars)
                        } else {
                            course.title
                        },
                        style = TextStyle(
                            color = ColorProvider(Color.White),
                            fontSize = if (span > 1) 10.sp else 9.sp,
                            fontWeight = FontWeight.Bold,
                            textAlign = TextAlign.Center,
                        ),
                        maxLines = if (span > 1) 3 else 2,
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
    }

    @Composable
    private fun CourseCellContinuation(
        color: Color,
        roundBottom: Boolean,
    ) {
        Box(modifier = GlanceModifier.fillMaxSize()) {
            RoundedCellBackground(
                color = color,
                roundTop = false,
                roundBottom = roundBottom,
            )
        }
    }

    /**
     * Draws a background with selective rounded corners.
     *
     * Uses a fully-rounded box overlaid with a plain rectangle
     * covering the half we want flat. Glance Box children stack
     * at TopStart, so a Column is used to push the cover rect
     * to the bottom when flattening bottom corners.
     */
    @Composable
    private fun RoundedCellBackground(
        color: Color,
        roundTop: Boolean,
        roundBottom: Boolean,
    ) {
        when {
            roundTop && roundBottom -> {
                // All corners rounded
                Box(
                    modifier = GlanceModifier
                        .fillMaxSize()
                        .cornerRadius(6.dp)
                        .background(color),
                ) {}
            }
            roundTop && !roundBottom -> {
                // Rounded top, flat bottom:
                // rounded box + rect covering bottom half
                Box(
                    modifier = GlanceModifier
                        .fillMaxSize()
                        .cornerRadius(6.dp)
                        .background(color),
                ) {}
                Column(modifier = GlanceModifier.fillMaxSize()) {
                    Box(modifier = GlanceModifier
                        .fillMaxWidth()
                        .defaultWeight()) {}
                    Box(
                        modifier = GlanceModifier
                            .fillMaxWidth()
                            .height((CELL_HEIGHT / 2).dp)
                            .background(color),
                    ) {}
                }
            }
            !roundTop && roundBottom -> {
                // Flat top, rounded bottom:
                // rounded box + rect covering top half
                Box(
                    modifier = GlanceModifier
                        .fillMaxSize()
                        .cornerRadius(6.dp)
                        .background(color),
                ) {}
                Box(
                    modifier = GlanceModifier
                        .fillMaxWidth()
                        .height((CELL_HEIGHT / 2).dp)
                        .background(color),
                ) {}
            }
            else -> {
                // No rounding — plain rectangle
                Box(
                    modifier = GlanceModifier
                        .fillMaxSize()
                        .background(color),
                ) {}
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
