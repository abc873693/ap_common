package me.rainvisitor.ap_common_plugin

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.appwidget.GlanceAppWidget
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
import androidx.glance.layout.ContentScale
import androidx.glance.layout.size
import kotlinx.serialization.json.Json
import java.text.SimpleDateFormat
import java.util.*

class CourseAppWidget : GlanceAppWidget() {
    companion object {
        private val json = Json { ignoreUnknownKeys = true }

        private val titleBackground = androidx.glance.color.ColorProvider(
            day = androidx.compose.ui.graphics.Color(0xFF2673FF),
            night = androidx.compose.ui.graphics.Color(0xFF141E2F),
        )
        private val contentBackground = androidx.glance.color.ColorProvider(
            day = androidx.compose.ui.graphics.Color.White,
            night = androidx.compose.ui.graphics.Color(0xFF121212),
        )
        private val titleTextColor = androidx.glance.color.ColorProvider(
            day = androidx.compose.ui.graphics.Color.White,
            night = androidx.compose.ui.graphics.Color.White,
        )
        private val contentTextColor = androidx.glance.color.ColorProvider(
            day = androidx.compose.ui.graphics.Color.Black,
            night = androidx.compose.ui.graphics.Color(0xFFBDBDBD),
        )
    }

    override suspend fun provideGlance(
        context: Context,
        id: GlanceId
    ) {
        val content = loadCourseContent(context)
        provideContent {
            GlanceTheme {
                CourseWidgetContent(context, content)
            }
        }
    }

    @Composable
    private fun CourseWidgetContent(context: Context, content: String) {
        val launchIntent = context.packageManager
            .getLaunchIntentForPackage(context.packageName)
        Column(
            modifier = GlanceModifier.fillMaxSize()
                .background(contentBackground),
        ) {
            // Title bar
            Row(
                modifier = GlanceModifier.fillMaxWidth()
                    .height(36.dp)
                    .background(titleBackground),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Box(
                    modifier = GlanceModifier.defaultWeight()
                        .padding(start = 8.dp),
                    contentAlignment = Alignment.Center,
                ) {
                    Text(
                        text = context.getString(R.string.course_hint),
                        style = TextStyle(
                            color = titleTextColor,
                            fontSize = 18.sp,
                            fontWeight = FontWeight.Bold,
                        ),
                    )
                }
                Image(
                    provider = ImageProvider(R.drawable.ic_refresh),
                    contentDescription = "Refresh",
                    modifier = GlanceModifier
                        .size(36.dp)
                        .padding(8.dp)
                        .clickable(
                            actionRunCallback<RefreshAction>()
                        ),
                )
            }

            // Content area
            Box(
                modifier = GlanceModifier.fillMaxSize()
                    .padding(8.dp)
                    .then(
                        if (launchIntent?.component != null) {
                            GlanceModifier.clickable(
                                actionStartActivity(launchIntent.component!!)
                            )
                        } else {
                            GlanceModifier
                        }
                    ),
                contentAlignment = Alignment.Center,
            ) {
                Text(
                    text = content,
                    style = TextStyle(
                        color = contentTextColor,
                        fontSize = 16.sp,
                        textAlign = TextAlign.Center,
                    ),
                )
            }
        }
    }

    private fun loadCourseContent(context: Context): String {
        val preference = context.getSharedPreferences(
            ApCommonPlugin.PREF_NAME,
            Context.MODE_PRIVATE,
        )
        val rawData = preference.getString(
            ApCommonPlugin.KEY_COURSE_NOTIFY, ""
        )
        if (rawData.isNullOrEmpty()) {
            return context.getString(R.string.not_load_course_table)
        }
        return parseNextCourse(context, rawData)
    }

    private fun parseNextCourse(
        context: Context,
        rawData: String
    ): String {
        val courseData = try {
            json.decodeFromString<CourseData>(rawData)
        } catch (e: Exception) {
            return context.getString(R.string.not_load_course_table)
        }

        val now = Calendar.getInstance()
        val todayCourses = parseTodayCourses(now, courseData)

        if (todayCourses.isEmpty()) {
            return context.getString(R.string.today_no_course)
        }

        val timeFormat = SimpleDateFormat("HH:mm", Locale.TAIWAN)
        val timeFormatCompact = SimpleDateFormat("HHmm", Locale.TAIWAN)
        var minDiff: Long = Long.MAX_VALUE
        var text = context.getString(R.string.today_no_course_already)

        for ((course, timeCode) in todayCourses) {
            val startTimeText = timeCode.startTime
            val parsed = if (startTimeText.length == 4) {
                timeFormatCompact.parse(startTimeText)
            } else {
                timeFormat.parse(startTimeText)
            } ?: continue

            val startCal = Calendar.getInstance().apply {
                time = parsed
            }
            val time = Calendar.getInstance().apply {
                set(Calendar.HOUR_OF_DAY, startCal.get(Calendar.HOUR_OF_DAY))
                set(Calendar.MINUTE, startCal.get(Calendar.MINUTE))
            }

            if (now.before(time)) {
                val diff = time.timeInMillis - now.timeInMillis
                if (diff < minDiff) {
                    minDiff = diff
                    text = String.format(
                        context.getString(
                            R.string.course_hint_content_format
                        ),
                        timeCode.startTime,
                        course.location?.displayText.orEmpty(),
                        course.title,
                    )
                }
            }
        }
        return text
    }

    private fun parseTodayCourses(
        today: Calendar,
        courseData: CourseData
    ): List<Pair<Course, TimeCode>> {
        val result = mutableListOf<Pair<Course, TimeCode>>()
        val rawWeekday = today.get(Calendar.DAY_OF_WEEK)
        val weekday =
            if (rawWeekday == Calendar.SUNDAY) 7 else rawWeekday - 1

        for (course in courseData.courses) {
            for (sectionTime in course.times) {
                if (sectionTime.weekday == weekday &&
                    sectionTime.index < courseData.timeCodes.size
                ) {
                    result.add(
                        course to courseData.timeCodes[sectionTime.index]
                    )
                }
            }
        }
        return result
    }
}
