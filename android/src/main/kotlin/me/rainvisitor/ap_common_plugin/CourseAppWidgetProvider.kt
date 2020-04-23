package me.rainvisitor.ap_common_plugin

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.RemoteViews
import org.json.JSONArray
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
            var rawData = preference.getString("flutter.ap_common.course_data_latest", "")
            val content = if (rawData == "") context.getString(R.string.not_load_course_table) else parseNextCurse(context, rawData)
            setTextViewText(R.id.content, content)
        }
    }

    private fun parseNextCurse(context: Context, rawData: String): String {
        val now = Calendar.getInstance()
        val courseData = JSONObject(rawData)
        val courseTable = courseData.getJSONObject("coursetable")
        val courses = parseCourseList(now, courseTable)
        val sourceDateformat = SimpleDateFormat("HH:mm", Locale.TAIWAN);
        var text = context.getString(R.string.today_no_course_already)
        var min: Long = now.timeInMillis
        Log.e("now", now.time.toString())
        if (courses.length() == 0)
            text = context.getString(R.string.today_no_course)
        for (i in 0 until courses.length()) {
            val course = courses.getJSONObject(i)
            val date = course.getJSONObject("date")
            val starTime = Calendar.getInstance()
            starTime.time = sourceDateformat.parse(date.getString("startTime"))
            val time = Calendar.getInstance()
            time.set(Calendar.HOUR_OF_DAY, starTime.get(Calendar.HOUR_OF_DAY))
            time.set(Calendar.MINUTE, starTime.get(Calendar.MINUTE))
            if (now.before(time)) {
                val diff = time.timeInMillis - now.timeInMillis
                if (min > diff) {
                    min = diff
                    val location = course.getJSONObject("location")
                    text = String.format(context.getString(R.string.course_hint_content_format),
                            date.getString("startTime"),
                            location.get("building"),
                            course.getString("title")
                    )
                }
            }
        }
        return text
    }

    private fun parseCourseList(today: Calendar, courseTable: JSONObject): JSONArray {
        return when (today.get(Calendar.DAY_OF_WEEK)) {
            1 -> courseTable.getJSONArray("Sunday")
            2 -> courseTable.getJSONArray("Monday")
            3 -> courseTable.getJSONArray("Tuesday")
            4 -> courseTable.getJSONArray("Wednesday")
            5 -> courseTable.getJSONArray("Thursday")
            6 -> courseTable.getJSONArray("Friday")
            else -> courseTable.getJSONArray("Saturday")
        }
    }
}