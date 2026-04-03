package me.rainvisitor.ap_common_plugin

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Build
import android.widget.RemoteViews
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.*

class CourseAppWidgetProvider : AppWidgetProvider() {
    companion object {
        private const val ACTION_REFRESH = "refresh"
    }

    override fun onReceive(context: Context, intent: Intent?) {
        super.onReceive(context, intent)
        if (intent?.action == ACTION_REFRESH) {
            val views = refreshView(context)
            AppWidgetManager.getInstance(context).updateAppWidget(
                ComponentName(context, CourseAppWidgetProvider::class.java),
                views
            )
        }
    }

    private fun getPendingSelfIntent(context: Context, action: String): PendingIntent {
        val intent = Intent(context, javaClass)
        intent.action = action
        val flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            PendingIntent.FLAG_MUTABLE
        } else {
            PendingIntent.FLAG_UPDATE_CURRENT
        }
        return PendingIntent.getBroadcast(context, 0, intent, flags)
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val views = refreshView(context)
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    private fun refreshView(context: Context): RemoteViews {
        val packageName: String = context.packageName
        val launchIntent = context.packageManager.getLaunchIntentForPackage(packageName)
        val flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            PendingIntent.FLAG_MUTABLE
        } else {
            PendingIntent.FLAG_UPDATE_CURRENT
        }
        val pendingIntent: PendingIntent =
            PendingIntent.getActivity(context, 0, launchIntent, flags)

        return RemoteViews(
            context.packageName,
            R.layout.course_appwidget_provider_layout
        ).apply {
            setOnClickPendingIntent(R.id.refresh, getPendingSelfIntent(context, ACTION_REFRESH))
            setOnClickPendingIntent(R.id.content, pendingIntent)

            val preference = context.getSharedPreferences(
                ApCommonPlugin.PREF_NAME,
                Context.MODE_PRIVATE
            )
            val rawData = preference.getString(ApCommonPlugin.KEY_COURSE_NOTIFY, "")
            val content = if (rawData.isNullOrEmpty()) {
                context.getString(R.string.not_load_course_table)
            } else {
                parseNextCourse(context, rawData)
            }
            setTextViewText(R.id.content, content)
        }
    }

    private fun parseNextCourse(context: Context, rawData: String): String {
        val now = Calendar.getInstance()
        val courseData = JSONObject(rawData)
        val todayCourses = parseCourseList(now, courseData)
        val timeFormat = SimpleDateFormat("HH:mm", Locale.TAIWAN)
        val timeFormatCompact = SimpleDateFormat("HHmm", Locale.TAIWAN)
        var text = context.getString(R.string.today_no_course_already)
        var minDiff: Long = Long.MAX_VALUE

        if (todayCourses.isEmpty()) {
            return context.getString(R.string.today_no_course)
        }

        for (course in todayCourses) {
            val startTimeText = course.startTime
            val parsed = if (startTimeText.length == 4) {
                timeFormatCompact.parse(startTimeText)
            } else {
                timeFormat.parse(startTimeText)
            } ?: continue

            val startCal = Calendar.getInstance()
            startCal.time = parsed
            val time = Calendar.getInstance()
            time.set(Calendar.HOUR_OF_DAY, startCal.get(Calendar.HOUR_OF_DAY))
            time.set(Calendar.MINUTE, startCal.get(Calendar.MINUTE))

            if (now.before(time)) {
                val diff = time.timeInMillis - now.timeInMillis
                if (diff < minDiff) {
                    minDiff = diff
                    text = String.format(
                        context.getString(R.string.course_hint_content_format),
                        course.startTime,
                        course.location,
                        course.title
                    )
                }
            }
        }
        return text
    }

    private fun parseCourseList(today: Calendar, courseData: JSONObject): List<Course> {
        val todayCourses = mutableListOf<Course>()
        if (courseData.isNull("courses")) return todayCourses

        val allCourses = courseData.getJSONArray("courses")
        val timeCodes = courseData.getJSONArray("timeCodes")
        var weekday = today.get(Calendar.DAY_OF_WEEK)
        weekday = if (weekday == 1) 7 else weekday - 1

        for (i in 0 until allCourses.length()) {
            val course = allCourses.getJSONObject(i)
            val times = course.getJSONArray("sectionTimes")
            for (j in 0 until times.length()) {
                if (times.getJSONObject(j).getInt("weekday") == weekday) {
                    val location = course.optJSONObject("location")
                    val sectionIndex = times.getJSONObject(j).getInt("index")
                    val startTime = timeCodes.getJSONObject(sectionIndex)
                        .getString("startTime")
                    val building = location?.optString("building", "") ?: ""
                    val room = location?.optString("room", "") ?: ""
                    val locationText = listOf(building, room)
                        .filter { it.isNotEmpty() && it != "null" }
                        .joinToString("")
                    todayCourses.add(
                        Course(
                            location = locationText,
                            title = course.getString("title"),
                            startTime = startTime
                        )
                    )
                }
            }
        }
        return todayCourses
    }
}
