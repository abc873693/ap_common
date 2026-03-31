package me.rainvisitor.ap_common_plugin

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ApCommonPlugin */
class ApCommonPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    companion object {
        const val PREF_NAME = "ap_common_plugin"
        const val KEY_COURSE_NOTIFY = "course_notify"
    }

    override fun onAttachedToEngine(
        @NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
    ) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(
            flutterPluginBinding.flutterEngine.dartExecutor,
            "ap_common_plugin"
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "configure" -> {
                // No-op on Android; App Group is iOS-only.
                result.success(null)
            }
            "updateCourseWidget" -> {
                val json = call.arguments as? String
                if (json == null) {
                    result.error("INVALID_ARGUMENT", "Course data JSON is required", null)
                    return
                }
                val prefs = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
                prefs.edit().putString(KEY_COURSE_NOTIFY, json).apply()
                notifyWidgetUpdate()
                result.success(null)
            }
            "clearCourseWidget" -> {
                val prefs = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
                prefs.edit().remove(KEY_COURSE_NOTIFY).apply()
                notifyWidgetUpdate()
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun notifyWidgetUpdate() {
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val widgetComponent = ComponentName(context, CourseAppWidgetProvider::class.java)
        val widgetIds = appWidgetManager.getAppWidgetIds(widgetComponent)
        if (widgetIds.isNotEmpty()) {
            appWidgetManager.notifyAppWidgetViewDataChanged(widgetIds, android.R.id.text1)
            CourseAppWidgetProvider().onUpdate(context, appWidgetManager, widgetIds)
        }
    }

    override fun onDetachedFromEngine(
        @NonNull binding: FlutterPlugin.FlutterPluginBinding
    ) {
        channel.setMethodCallHandler(null)
    }
}
