#import "SMultiloginpPlugin.h"
#if __has_include(<s_multiloginp/s_multiloginp-Swift.h>)
#import <s_multiloginp/s_multiloginp-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "s_multiloginp-Swift.h"
#endif

@implementation SMultiloginpPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSMultiloginpPlugin registerWithRegistrar:registrar];
}
@end
