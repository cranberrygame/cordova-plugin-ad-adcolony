//Copyright (c) 2014 Sang Ki Kwon (Cranberrygame)
//Email: cranberrygame@yahoo.com
//Homepage: http://cranberrygame.github.io
//License: MIT (http://opensource.org/licenses/MIT)
#import <Cordova/CDV.h>
#import <AdColony/AdColony.h>

@interface AdColonyPlugin : CDVPlugin

@property NSString *callbackIdKeepCallback;
//
@property NSString *email;
@property NSString *licenseKey_;
@property BOOL validLicenseKey;
//
@property NSString *appId;
@property NSString *interstitialAdZoneId;
@property NSString *rewardedVideoAdZoneId;
	
- (void) setLicenseKey: (CDVInvokedUrlCommand*)command;
- (void) setUp:(CDVInvokedUrlCommand*)command;
- (void) showInterstitialAd:(CDVInvokedUrlCommand*)command;
- (void) showRewardedVideoAd:(CDVInvokedUrlCommand*)command;

@end

@interface MyAdColonyDelegate : NSObject <AdColonyDelegate>

@property AdColonyPlugin *adColonyPlugin;

- (id) initWithAdColonyPlugin:(AdColonyPlugin *)adColonyPlugin_ ;

@end

@interface AdColonyAdDelegateInterstitialAd : NSObject <AdColonyAdDelegate>

@property AdColonyPlugin *adColonyPlugin;

- (id) initWithAdColonyPlugin:(AdColonyPlugin *)adColonyPlugin_ ;

@end

@interface AdColonyAdDelegateRewardedVideoAd : NSObject <AdColonyAdDelegate>

@property AdColonyPlugin *adColonyPlugin;

- (id) initWithAdColonyPlugin:(AdColonyPlugin *)adColonyPlugin_ ;

@end
