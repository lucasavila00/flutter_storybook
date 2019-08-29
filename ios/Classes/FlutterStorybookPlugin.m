#import "FlutterStorybookPlugin.h"
#import <flutter_storybook/flutter_storybook-Swift.h>

@implementation FlutterStorybookPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterStorybookPlugin registerWithRegistrar:registrar];
}
@end
