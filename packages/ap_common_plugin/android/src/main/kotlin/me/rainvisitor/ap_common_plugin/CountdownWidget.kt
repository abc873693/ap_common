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
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import androidx.glance.action.actionStartActivity
import androidx.glance.action.clickable
import kotlinx.serialization.json.Json
import java.text.SimpleDateFormat
import java.util.*

/**
 * A small countdown widget showing minutes until the next class.
 */
class CountdownWidget : GlanceAppWidget() {
    companion object {
        private val json = Json { ignoreUnknownKeys = true }

        private val accentColor = Color(0xFF2673FF)
        private val surfaceBg = androidx.glance.color.ColorProvider(
            day = Color.White,
            night = Color(0xFF1A1C2E),
        )
        private val textPrimary = androidx.glance.color.ColorProvider(
            day = Color.Black,
            night = Color(0xFFE0E0E0),
        )
        private val textSecondary = androidx.glance.color.ColorProvider(
            day = Color(0xFF757575),
            night = Color(0xFF9E9E9E),
        )
    }

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val result = findNextCourse(context)
        provideContent {
            GlanceTheme {
                CountdownContent(context, result)
            }
        }
    }

    @Composable
    private fun CountdownContent(
        context: Context,
        result: NextCourseResult?,
    ) {
        val launchIntent = context.packageManager
            .getLaunchIntentForPackage(context.packageName)

        Box(
            modifier = GlanceModifier.fillMaxSize()
                .cornerRadius(16.dp)
                .background(surfaceBg)
                .then(
                    if (launchIntent?.component != null) {
                        GlanceModifier.clickable(
                            actionStartActivity(launchIntent.component!!)
                        )
                    } else GlanceModifier
                ),
            contentAlignment = Alignment.Center,
        ) {
            if (result == null) {
                // No more courses today
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    modifier = GlanceModifier.padding(12.dp),
                ) {
                    Text(
                        text = "🎉",
                        style = TextStyle(fontSize = 28.sp),
                    )
                    Spacer(modifier = GlanceModifier.height(4.dp))
                    Text(
                        text = context.getString(
                            R.string.today_no_course_already
                        ),
                        style = TextStyle(
                            color = textSecondary,
                            fontSize = 12.sp,
                            textAlign = TextAlign.Center,
                        ),
                    )
                }
            } else {
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    modifier = GlanceModifier.padding(8.dp),
                ) {
                    // Countdown number
                    Text(
                        text = result.minutesLeft.toString(),
                        style = TextStyle(
                            color = ColorProvider(accentColor),
                            fontSize = 40.sp,
                            fontWeight = FontWeight.Bold,
                        ),
                    )
                    Text(
                        text = context.getString(R.string.minutes_until),
                        style = TextStyle(
                            color = textSecondary,
                            fontSize = 11.sp,
                        ),
                    )
                    Spacer(modifier = GlanceModifier.height(6.dp))
                    // Course name
                    Text(
                        text = result.title,
                        style = TextStyle(
                            color = textPrimary,
                            fontSize = 13.sp,
                            fontWeight = FontWeight.Medium,
                            textAlign = TextAlign.Center,
                        ),
                        maxLines = 1,
                    )
                    // Time + location
                    Text(
                        text = "${result.startTime} · ${result.location}",
                        style = TextStyle(
                            color = textSecondary,
                            fontSize = 10.sp,
                            textAlign = TextAlign.Center,
                        ),
                        maxLines = 1,
                    )
                }
            }
        }
    }

    data class NextCourseResult(
        val title: String,
        val startTime: String,
        val location: String,
        val minutesLeft: Int,
    )

    private fun findNextCourse(context: Context): NextCourseResult? {
        val pref = context.getSharedPreferences(
            ApCommonPlugin.PREF_NAME, Context.MODE_PRIVATE,
        )
        val raw = pref.getString(ApCommonPlugin.KEY_COURSE_NOTIFY, "")
        if (raw.isNullOrEmpty()) return null

        val data = try {
            json.decodeFromString<CourseData>(raw)
        } catch (e: Exception) {
            return null
        }

        val now = Calendar.getInstance()
        val rawWd = now.get(Calendar.DAY_OF_WEEK)
        val weekday = if (rawWd == Calendar.SUNDAY) 7 else rawWd - 1
        val currentMs = now.timeInMillis

        val tf = SimpleDateFormat("HH:mm", Locale.getDefault())
        val tfc = SimpleDateFormat("HHmm", Locale.getDefault())

        var best: NextCourseResult? = null
        var bestDiff = Long.MAX_VALUE

        for (course in data.courses) {
            for (st in course.times) {
                if (st.weekday != weekday) continue
                if (st.index >= data.timeCodes.size) continue
                val tc = data.timeCodes[st.index]

                val parsed = if (tc.startTime.length == 4) {
                    tfc.parse(tc.startTime)
                } else {
                    tf.parse(tc.startTime)
                } ?: continue

                val startCal = Calendar.getInstance().apply {
                    val p = Calendar.getInstance().apply { time = parsed }
                    set(Calendar.HOUR_OF_DAY, p.get(Calendar.HOUR_OF_DAY))
                    set(Calendar.MINUTE, p.get(Calendar.MINUTE))
                    set(Calendar.SECOND, 0)
                }

                val diff = startCal.timeInMillis - currentMs
                if (diff > 0 && diff < bestDiff) {
                    bestDiff = diff
                    best = NextCourseResult(
                        title = course.title,
                        startTime = tc.startTime,
                        location = course.location?.displayText ?: "",
                        minutesLeft = (diff / 60000).toInt(),
                    )
                }
            }
        }
        return best
    }
}
