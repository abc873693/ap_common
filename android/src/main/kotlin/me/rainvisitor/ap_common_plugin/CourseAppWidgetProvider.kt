package me.rainvisitor.ap_common_plugin

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.*


class CourseAppWidgetProvider : AppWidgetProvider() {
    private val REFRESH = "refresh"

    override fun onReceive(context: Context, intent: Intent?) {
        super.onReceive(context, intent)

        if (intent != null) {
            if (REFRESH == intent.action) {
                val views = refreshView(context)
                AppWidgetManager.getInstance(context).updateAppWidget(
                        ComponentName(context, CourseAppWidgetProvider::class.java), views)
            }
        }
    }

    private fun getPendingSelfIntent(context: Context, action: String): PendingIntent? {
        val intent = Intent(context, javaClass) // An intent directed at the current class (the "self").
        intent.action = action
        return PendingIntent.getBroadcast(context, 0, intent, 0)
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
        val pendingIntent: PendingIntent = context.packageManager.getLaunchIntentForPackage(packageName)
                .let { intent ->
                    PendingIntent.getActivity(context, 0, intent, 0)
                }
        return RemoteViews(
                context.packageName,
                R.layout.course_appwidget_provider_layout
        ).apply {
            setOnClickPendingIntent(R.id.refresh, getPendingSelfIntent(context, REFRESH));
            setOnClickPendingIntent(R.id.content, pendingIntent)


            val preference = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val currentSemesterCode = preference.getString("flutter.ap_common.current_semester_code", "")
            val rawData = preference.getString("flutter.ap_common.course_data_${currentSemesterCode}", "")
            val content = if (rawData == "") context.getString(R.string.not_load_course_table) else parseNextCurse(context, rawData)
            setTextViewText(R.id.content, content)
        }
    }

    private fun parseNextCurse(context: Context, rawData: String): String {
        val now = Calendar.getInstance()
        val courseData = JSONObject(rawData)
        val todayCourses = parseCourseList(now, courseData)
        val sourceDateformat = SimpleDateFormat("HH:mm", Locale.TAIWAN)
        val sourceErrorDateformat = SimpleDateFormat("HHmm", Locale.TAIWAN)
        var text = context.getString(R.string.today_no_course_already)
        var min: Long = now.timeInMillis
        if (todayCourses.isEmpty())
            text = context.getString(R.string.today_no_course)
        for (i in todayCourses.indices) {
            val course = todayCourses[i]
            val starTime = Calendar.getInstance()
            val startTimeText = course.startTime
            starTime.time = if (startTimeText.length == 4) sourceErrorDateformat.parse(startTimeText) else sourceDateformat.parse(startTimeText)
            val time = Calendar.getInstance()
            time.set(Calendar.HOUR_OF_DAY, starTime.get(Calendar.HOUR_OF_DAY))
            time.set(Calendar.MINUTE, starTime.get(Calendar.MINUTE))
            if (now.before(time)) {
                val diff = time.timeInMillis - now.timeInMillis
                if (min > diff) {
                    min = diff
                    text = String.format(context.getString(R.string.course_hint_content_format),
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
        val allCourses = courseData.getJSONArray("courses")
        val timeCodes = courseData.getJSONArray("timeCodes")
        val todayCourses = mutableListOf<Course>()
        val weekday = today.get(Calendar.DAY_OF_WEEK)

        for (i in 0 until allCourses.length()) {
            val course = allCourses.getJSONObject(i)
            val times = course.getJSONArray("sectionTimes")
            for (j in 0 until times.length()) {
                if (times.getJSONObject(j).getInt("weekday") == weekday) {
                    val location = course.getJSONObject("location")
                    val sectionIndex = times.getJSONObject(j).getInt("index")
                    val startTime = timeCodes.getJSONObject(sectionIndex).getString("startTime")
                    todayCourses.add(Course(location = "${location.get("building")}${location.get("room")}", title = course.getString("title"), startTime = startTime))
                }
            }
        }
        return todayCourses
    }
}