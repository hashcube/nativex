#import "PluginManager.h"

@interface NativeXPlugin : GCPlugin <NativeXAdViewDelegate>
@interface AppDelegate () <NativeXSDKDelegate>

@property (retain, nonatomic) UINavigationController *navController;

@end
