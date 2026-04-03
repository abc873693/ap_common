package me.rainvisitor.ap_common_plugin

import android.content.Context
import androidx.annotation.NonNull
import androidx.glance.appwidget.GlanceAppWidgetManager
import androidx.glance.appwidget.updateAll
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/** ApCommonPlugin */
class ApCommonPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private val scope = CoroutineScope(Dispatchers.Main)

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
        scope.launch {
            CourseAppWidget().updateAll(context)
        }
    }

    override fun onDetachedFromEngine(
        @NonNull binding: FlutterPlugin.FlutterPluginBinding
    ) {
        channel.setMethodCallHandler(null)
    }
}
