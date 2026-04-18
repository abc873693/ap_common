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
        const val KEY_COURSE_PALETTE_ID = "course_palette_id"
        const val KEY_COURSE_PALETTE_COLORS = "course_palette_colors"
        const val KEY_COURSE_PALETTE_FOREGROUND =
            "course_palette_foreground"
        const val KEY_COURSE_PALETTE_DARK_COLORS =
            "course_palette_dark_colors"
        const val KEY_COURSE_PALETTE_DARK_FOREGROUND =
            "course_palette_dark_foreground"
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
            "updateUserInfoWidget" -> {
                val json = call.arguments as? String
                if (json == null) {
                    result.error("INVALID_ARGUMENT", "User info JSON is required", null)
                    return
                }
                val prefs = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
                prefs.edit().putString(StudentIdWidget.KEY_USER_INFO, json).apply()
                scope.launch {
                    StudentIdWidget().updateAll(context)
                }
                result.success(null)
            }
            "clearUserInfoWidget" -> {
                val prefs = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
                prefs.edit().remove(StudentIdWidget.KEY_USER_INFO).apply()
                scope.launch {
                    StudentIdWidget().updateAll(context)
                }
                result.success(null)
            }
            "setCoursePalette" -> {
                val args = call.arguments as? Map<*, *>
                if (args == null) {
                    result.error(
                        "INVALID_ARGUMENT",
                        "Palette arguments are required",
                        null,
                    )
                    return
                }
                val id = args["id"] as? String
                val colors = args["colors"] as? List<*>
                val foreground = (args["foregroundColor"] as? Number)?.toLong()
                if (id == null || colors == null || foreground == null) {
                    result.error(
                        "INVALID_ARGUMENT",
                        "id, colors, foregroundColor are required",
                        null,
                    )
                    return
                }
                val prefs = context.getSharedPreferences(
                    PREF_NAME,
                    Context.MODE_PRIVATE,
                )
                val editor = prefs.edit()
                    .putString(KEY_COURSE_PALETTE_ID, id)
                    .putString(
                        KEY_COURSE_PALETTE_COLORS,
                        colors.joinToString(",") {
                            ((it as? Number)?.toLong() ?: 0L).toString()
                        },
                    )
                    .putLong(KEY_COURSE_PALETTE_FOREGROUND, foreground)
                val darkColors = args["darkColors"] as? List<*>
                val darkForeground =
                    (args["darkForegroundColor"] as? Number)?.toLong()
                if (darkColors != null && darkForeground != null) {
                    editor
                        .putString(
                            KEY_COURSE_PALETTE_DARK_COLORS,
                            darkColors.joinToString(",") {
                                ((it as? Number)?.toLong() ?: 0L).toString()
                            },
                        )
                        .putLong(
                            KEY_COURSE_PALETTE_DARK_FOREGROUND,
                            darkForeground,
                        )
                } else {
                    editor
                        .remove(KEY_COURSE_PALETTE_DARK_COLORS)
                        .remove(KEY_COURSE_PALETTE_DARK_FOREGROUND)
                }
                editor.apply()
                notifyWidgetUpdate()
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun notifyWidgetUpdate() {
        scope.launch {
            CourseAppWidget().updateAll(context)
            CourseTableWidget().updateAll(context)
            TodayScheduleWidget().updateAll(context)
            CountdownWidget().updateAll(context)
        }
    }

    override fun onDetachedFromEngine(
        @NonNull binding: FlutterPlugin.FlutterPluginBinding
    ) {
        channel.setMethodCallHandler(null)
    }
}
