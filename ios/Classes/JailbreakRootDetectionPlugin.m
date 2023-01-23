#import "JailbreakRootDetectionPlugin.h"
#if __has_include(<jailbreak_root_detection/jailbreak_root_detection-Swift.h>)
#import <jailbreak_root_detection/jailbreak_root_detection-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "jailbreak_root_detection-Swift.h"
#endif

@implementation JailbreakRootDetectionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJailbreakRootDetectionPlugin registerWithRegistrar:registrar];
}
@end
