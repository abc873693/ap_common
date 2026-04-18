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
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.size
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
import kotlinx.serialization.json.Json
import java.text.SimpleDateFormat
import java.util.*

/**
 * Shows today's course list in a vertical timeline layout.
 */
class TodayScheduleWidget : GlanceAppWidget() {
    companion object {
        private val json = Json { ignoreUnknownKeys = true }

        private val headerBg = androidx.glance.color.ColorProvider(
            day = Color(0xFF2673FF),
            night = Color(0xFF1A1C2E),
        )
        private val surfaceBg = androidx.glance.color.ColorProvider(
            day = Color.White,
            night = Color(0xFF121212),
        )
        private val textPrimary = androidx.glance.color.ColorProvider(
            day = Color.Black,
            night = Color(0xFFE0E0E0),
        )
        private val textSecondary = androidx.glance.color.ColorProvider(
            day = Color(0xFF757575),
            night = Color(0xFF9E9E9E),
        )
        private val nowIndicator = Color(0xFFEF5350)
    }

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val data = loadData(context)
        val todayCourses = if (data != null) getTodayCourses(data) else emptyList()
        provideContent {
            GlanceTheme {
                TodayContent(context, todayCourses)
            }
        }
    }

    @Composable
    private fun TodayContent(
        context: Context,
        courses: List<ScheduleItem>,
    ) {
        val palette = CoursePalette.resolve(context).colors
        val launchIntent = context.packageManager
            .getLaunchIntentForPackage(context.packageName)

        Column(
            modifier = GlanceModifier.fillMaxSize()
                .background(surfaceBg)
                .cornerRadius(16.dp)
                .then(
                    if (launchIntent?.component != null) {
                        GlanceModifier.clickable(
                            actionStartActivity(launchIntent.component!!)
                        )
                    } else GlanceModifier
                ),
        ) {
            // Header
            Box(
                modifier = GlanceModifier.fillMaxWidth()
                    .height(32.dp)
                    .background(headerBg),
                contentAlignment = Alignment.Center,
            ) {
                val cal = Calendar.getInstance()
                val dayNames = context.resources.getStringArray(
                    R.array.weekday_labels
                )
                val raw = cal.get(Calendar.DAY_OF_WEEK)
                val wd = if (raw == Calendar.SUNDAY) 6 else raw - 2
                val dayName = dayNames.getOrElse(wd) { "" }
                Text(
                    text = "${context.getString(R.string.today_schedule)} ($dayName)",
                    style = TextStyle(
                        color = ColorProvider(Color.White),
                        fontSize = 13.sp,
                        fontWeight = FontWeight.Bold,
                    ),
                )
            }

            if (courses.isEmpty()) {
                Box(
                    modifier = GlanceModifier.fillMaxSize(),
                    contentAlignment = Alignment.Center,
                ) {
                    Text(
                        text = context.getString(R.string.today_no_course),
                        style = TextStyle(
                            color = textSecondary,
                            fontSize = 14.sp,
                            textAlign = TextAlign.Center,
                        ),
                    )
                }
            } else {
                Column(
                    modifier = GlanceModifier.fillMaxSize()
                        .padding(horizontal = 12.dp, vertical = 8.dp),
                ) {
                    for ((index, item) in courses.withIndex()) {
                        ScheduleRow(item, index, palette)
                        if (index < courses.size - 1) {
                            Spacer(modifier = GlanceModifier.height(6.dp))
                        }
                    }
                }
            }
        }
    }

    @Composable
    private fun ScheduleRow(
        item: ScheduleItem,
        index: Int,
        palette: List<Color>,
    ) {
        val color = palette[
            item.course.code.hashCode().let {
                ((it % palette.size) + palette.size) % palette.size
            }
        ]

        Row(
            modifier = GlanceModifier.fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            // Time
            Column(
                modifier = GlanceModifier.width(44.dp),
                horizontalAlignment = Alignment.End,
            ) {
                Text(
                    text = item.startTime,
                    style = TextStyle(
                        color = if (item.isPast) textSecondary
                        else textPrimary,
                        fontSize = 12.sp,
                        fontWeight = FontWeight.Bold,
                    ),
                )
                Text(
                    text = item.endTime,
                    style = TextStyle(
                        color = textSecondary,
                        fontSize = 9.sp,
                    ),
                )
            }
            
            Spacer(modifier = GlanceModifier.width(8.dp))

            // Color bar
            Box(
                modifier = GlanceModifier
                    .width(4.dp)
                    .height(36.dp)
                    .cornerRadius(2.dp)
                    .background(
                        if (item.isPast) Color(0xFFBDBDBD) else color
                    ),
            ) {}

            Spacer(modifier = GlanceModifier.width(8.dp))

            // Course info
            Column(modifier = GlanceModifier.defaultWeight()) {
                Text(
                    text = item.course.title,
                    style = TextStyle(
                        color = if (item.isPast) textSecondary
                        else textPrimary,
                        fontSize = 13.sp,
                        fontWeight = FontWeight.Medium,
                    ),
                    maxLines = 1,
                )
                val loc = item.course.location?.displayText
                if (!loc.isNullOrEmpty()) {
                    Text(
                        text = loc,
                        style = TextStyle(
                            color = textSecondary,
                            fontSize = 10.sp,
                        ),
                        maxLines = 1,
                    )
                }
            }
        }
    }

    // --- Data ---

    data class ScheduleItem(
        val course: Course,
        val startTime: String,
        val endTime: String,
        val timeIndex: Int,
        val isPast: Boolean,
    )

    private fun getTodayCourses(data: CourseData): List<ScheduleItem> {
        val now = Calendar.getInstance()
        val rawWd = now.get(Calendar.DAY_OF_WEEK)
        val weekday = if (rawWd == Calendar.SUNDAY) 7 else rawWd - 1

        val timeFormat = SimpleDateFormat("HH:mm", Locale.getDefault())
        val timeFormatCompact = SimpleDateFormat("HHmm", Locale.getDefault())
        val currentMinutes = now.get(Calendar.HOUR_OF_DAY) * 60 +
            now.get(Calendar.MINUTE)

        val items = mutableListOf<ScheduleItem>()
        for (course in data.courses) {
            for (st in course.times) {
                if (st.weekday != weekday) continue
                if (st.index >= data.timeCodes.size) continue
                val tc = data.timeCodes[st.index]

                val endParsed = if (tc.endTime.length == 4) {
                    timeFormatCompact.parse(tc.endTime)
                } else {
                    timeFormat.parse(tc.endTime)
                }
                val endCal = Calendar.getInstance().apply {
                    if (endParsed != null) time = endParsed
                }
                val endMinutes = endCal.get(Calendar.HOUR_OF_DAY) * 60 +
                    endCal.get(Calendar.MINUTE)

                items.add(
                    ScheduleItem(
                        course = course,
                        startTime = tc.startTime,
                        endTime = tc.endTime,
                        timeIndex = st.index,
                        isPast = currentMinutes > endMinutes,
                    )
                )
            }
        }

        // Merge consecutive slots of the same course
        val sorted = items.sortedBy { it.startTime }
        val merged = mutableListOf<ScheduleItem>()
        for (item in sorted) {
            val last = merged.lastOrNull()
            if (last != null &&
                last.course.code == item.course.code &&
                item.timeIndex == last.timeIndex + 1
            ) {
                merged[merged.lastIndex] = last.copy(
                    endTime = item.endTime,
                    isPast = item.isPast,
                )
            } else {
                merged.add(item)
            }
        }
        return merged
    }

    private fun loadData(context: Context): CourseData? {
        val pref = context.getSharedPreferences(
            ApCommonPlugin.PREF_NAME, Context.MODE_PRIVATE,
        )
        val raw = pref.getString(ApCommonPlugin.KEY_COURSE_NOTIFY, "")
        if (raw.isNullOrEmpty()) return null
        return try {
            json.decodeFromString<CourseData>(raw)
        } catch (e: Exception) {
            null
        }
    }
}
