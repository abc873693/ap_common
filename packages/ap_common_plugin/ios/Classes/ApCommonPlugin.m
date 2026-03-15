#import "ApCommonPlugin.h"
#if __has_include(<ap_common_plugin/ap_common_plugin-Swift.h>)
#import <ap_common_plugin/ap_common_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ap_common_plugin-Swift.h"
#endif

@implementation ApCommonPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftApCommonPlugin registerWithRegistrar:registrar];
}
@end
