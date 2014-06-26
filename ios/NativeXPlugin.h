#import "PluginManager.h"
#import "NativeXiOSSDK-5_0_5/NativeXSDKHeaders/NativeXSDK.h"

@interface NativeXPlugin : GCPlugin <NativeXAdViewDelegate, NativeXSDKDelegate>

@property (retain, nonatomic) UINavigationController *navController;
@property BOOL cached;
@property (assign) NSString* appid;
@end
