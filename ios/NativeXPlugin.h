#import "PluginManager.h"
#import "NativeXSDK.h"

@interface NativeXPlugin : GCPlugin <NativeXAdViewDelegate, NativeXSDKDelegate>

@property (retain, nonatomic) UINavigationController *navController;
@property BOOL cached;
@property (assign) NSString* appid;
@end
