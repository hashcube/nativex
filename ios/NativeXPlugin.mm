#import "NativeXPlugin.h"

@implementation NativeXPlugin

// The plugin must call super dealloc.
- (void) dealloc {
	[super dealloc];
}

// The plugin must call super init.
- (id) init {
	self = [super init];
	if (!self) {
		return nil;
	}
    self.cached = false;

	return self;
}

// Called if the SDK initiates successfully
- (void)nativeXSDKDidCreateSession{ }

// Called if the SDK fails to initiate.
- (void)nativeXSDKDidFailToCreateSession:(NSError *)error{ }

- (void)nativeXAdView:(NativeXAdView *)adView didLoadWithPlacement:(NSString *)placement {
    //Called when an ad has been loaded/cached and is ready to be shown
    self.cached = true;
    [[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
                                          @"NativeXAdAvailable",@"name",
                                          nil]];
}

- (void)nativeXAdViewNoAdContent:(NativeXAdView *)adView {
    self.cached = false;
    [[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
                                          @"NativeXAdNotAvailable",@"name",
                                          nil]];
}

- (void)nativeXAdViewWillDismiss:(NativeXAdView *)adView {
    [[PluginManager get] dispatchJSEvent:[NSDictionary dictionaryWithObjectsAndKeys:
                                          @"NativeXAdDismissed",@"name",
                                          nil]];
}

- (void) cacheInterstitial:(NSDictionary *) dummy {
    [[NativeXSDK sharedInstance] fetchAdWithPlacement:kAdPlacementLevelCompleted delegate:self];
}

- (void) showInterstitial:(NSDictionary *) dummy {
    if (self.cached) {
        [[NativeXSDK sharedInstance] showAdWithPlacement:kAdPlacementLevelCompleted];
        self.cached = false;
    }
}

- (void) initializeWithManifest:(NSDictionary *)manifest appDelegate:(TeaLeafAppDelegate *)appDelegate {
    NSDictionary *ios = [manifest valueForKey:@"ios"];
    NSString *appid = [ios valueForKey:@"nativexappid"];

    self.appid = appid;
    [[NativeXSDK sharedInstance] setDelegate:self];
    [[NativeXSDK sharedInstance] createSessionWithAppId:self.appid];
    [[NativeXSDK sharedInstance] setShouldOutputDebugLog:YES];
}

- (void) applicationWillTerminate:(UIApplication *)app {
}

- (void) applicationDidBecomeActive:(UIApplication *)app {
}

- (void) handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
}

- (void) didBecomeActive:(NSDictionary *)jsonObject {
}

@end
