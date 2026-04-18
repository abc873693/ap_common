import Flutter
import UIKit
import WidgetKit

public class SwiftApCommonPlugin: NSObject, FlutterPlugin {
    private static let keyAppGroupId = "app_group_id"
    private static let keyCourseNotify = "course_notify"
    private static let keyUserInfo = "user_info"
    private static let keyCoursePaletteId = "course_palette_id"
    private static let keyCoursePaletteColors = "course_palette_colors"
    private static let keyCoursePaletteForeground =
        "course_palette_foreground"
    private static let keyCoursePaletteDarkColors =
        "course_palette_dark_colors"
    private static let keyCoursePaletteDarkForeground =
        "course_palette_dark_foreground"
    private static let prefName = "ap_common_plugin"

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "ap_common_plugin",
            binaryMessenger: registrar.messenger()
        )
        let instance = SwiftApCommonPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "configure":
            guard let args = call.arguments as? [String: String],
                  let appGroupId = args["appGroupId"] else {
                result(
                    FlutterError(
                        code: "INVALID_ARGUMENT",
                        message: "appGroupId is required",
                        details: nil
                    )
                )
                return
            }
            let prefs = UserDefaults.standard
            prefs.set(appGroupId, forKey: SwiftApCommonPlugin.keyAppGroupId)
            result(nil)
        case "updateCourseWidget":
            guard let json = call.arguments as? String else {
                result(
                    FlutterError(
                        code: "INVALID_ARGUMENT",
                        message: "Course data JSON is required",
                        details: nil
                    )
                )
                return
            }
            let appGroupId = UserDefaults.standard.string(
                forKey: SwiftApCommonPlugin.keyAppGroupId
            )
            if let appGroupId = appGroupId,
               let groupDefaults = UserDefaults(suiteName: appGroupId) {
                groupDefaults.set(json, forKey: SwiftApCommonPlugin.keyCourseNotify)
            }
            if #available(iOS 14.0, *) {
                WidgetCenter.shared.reloadAllTimelines()
            }
            result(nil)
        case "clearCourseWidget":
            let appGroupId = UserDefaults.standard.string(
                forKey: SwiftApCommonPlugin.keyAppGroupId
            )
            if let appGroupId = appGroupId,
               let groupDefaults = UserDefaults(suiteName: appGroupId) {
                groupDefaults.removeObject(forKey: SwiftApCommonPlugin.keyCourseNotify)
            }
            if #available(iOS 14.0, *) {
                WidgetCenter.shared.reloadAllTimelines()
            }
            result(nil)
        case "updateUserInfoWidget":
            guard let json = call.arguments as? String else {
                result(
                    FlutterError(
                        code: "INVALID_ARGUMENT",
                        message: "User info JSON is required",
                        details: nil
                    )
                )
                return
            }
            let appGroupId = UserDefaults.standard.string(
                forKey: SwiftApCommonPlugin.keyAppGroupId
            )
            if let appGroupId = appGroupId,
               let groupDefaults = UserDefaults(suiteName: appGroupId) {
                groupDefaults.set(json, forKey: SwiftApCommonPlugin.keyUserInfo)
            }
            if #available(iOS 14.0, *) {
                WidgetCenter.shared.reloadAllTimelines()
            }
            result(nil)
        case "clearUserInfoWidget":
            let appGroupId = UserDefaults.standard.string(
                forKey: SwiftApCommonPlugin.keyAppGroupId
            )
            if let appGroupId = appGroupId,
               let groupDefaults = UserDefaults(suiteName: appGroupId) {
                groupDefaults.removeObject(forKey: SwiftApCommonPlugin.keyUserInfo)
            }
            if #available(iOS 14.0, *) {
                WidgetCenter.shared.reloadAllTimelines()
            }
            result(nil)
        case "setCoursePalette":
            guard let args = call.arguments as? [String: Any],
                  let id = args["id"] as? String,
                  let colors = args["colors"] as? [Int64],
                  let foreground = args["foregroundColor"] as? Int64 else {
                result(
                    FlutterError(
                        code: "INVALID_ARGUMENT",
                        message: "id, colors, foregroundColor are required",
                        details: nil
                    )
                )
                return
            }
            let appGroupId = UserDefaults.standard.string(
                forKey: SwiftApCommonPlugin.keyAppGroupId
            )
            if let appGroupId = appGroupId,
               let groupDefaults = UserDefaults(suiteName: appGroupId) {
                groupDefaults.set(
                    id,
                    forKey: SwiftApCommonPlugin.keyCoursePaletteId
                )
                groupDefaults.set(
                    colors,
                    forKey: SwiftApCommonPlugin.keyCoursePaletteColors
                )
                groupDefaults.set(
                    foreground,
                    forKey: SwiftApCommonPlugin.keyCoursePaletteForeground
                )
                if let darkColors = args["darkColors"] as? [Int64],
                   let darkForeground =
                    args["darkForegroundColor"] as? Int64 {
                    groupDefaults.set(
                        darkColors,
                        forKey:
                            SwiftApCommonPlugin.keyCoursePaletteDarkColors
                    )
                    groupDefaults.set(
                        darkForeground,
                        forKey:
                            SwiftApCommonPlugin
                            .keyCoursePaletteDarkForeground
                    )
                } else {
                    groupDefaults.removeObject(
                        forKey:
                            SwiftApCommonPlugin.keyCoursePaletteDarkColors
                    )
                    groupDefaults.removeObject(
                        forKey:
                            SwiftApCommonPlugin
                            .keyCoursePaletteDarkForeground
                    )
                }
            }
            if #available(iOS 14.0, *) {
                WidgetCenter.shared.reloadAllTimelines()
            }
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
