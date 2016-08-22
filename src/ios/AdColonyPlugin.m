//Copyright (c) 2014 Sang Ki Kwon (Cranberrygame)
//Email: cranberrygame@yahoo.com
//Homepage: http://cranberrygame.github.io
//License: MIT (http://opensource.org/licenses/MIT)
#import "AdColonyPlugin.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <CommonCrypto/CommonDigest.h> //md5

@implementation AdColonyPlugin

@synthesize callbackIdKeepCallback;
//
@synthesize email;
@synthesize licenseKey_;
@synthesize validLicenseKey;
static NSString *TEST_APP_ID = @"appea37823f227444bcb2";
static NSString *TEST_INTERSTITIAL_AD_ZONE_ID = @"vzc77c6ffd0b924e0283";
static NSString *TEST_REWARDED_VIDEO_AD_ZONE_ID = @"vzac89782a8e01437fbf";
//
@synthesize appId;
@synthesize interstitialAdZoneId;
@synthesize rewardedVideoAdZoneId;

- (void) pluginInitialize {
    [super pluginInitialize];    
    //
}

- (void) setLicenseKey: (CDVInvokedUrlCommand*)command {
    NSString *email = [command.arguments objectAtIndex: 0];
    NSString *licenseKey = [command.arguments objectAtIndex: 1];
    NSLog(@"%@", email);
    NSLog(@"%@", licenseKey);
    
    [self.commandDelegate runInBackground:^{
        [self _setLicenseKey:email aLicenseKey:licenseKey];
    }];
}

- (void) setUp: (CDVInvokedUrlCommand*)command {
    //self.viewController
    //self.webView	
    //NSString *adUnitBanner = [command.arguments objectAtIndex: 0];
    //NSString *adUnitInterstitial = [command.arguments objectAtIndex: 1];
    //BOOL isOverlap = [[command.arguments objectAtIndex: 2] boolValue];
    //BOOL isTest = [[command.arguments objectAtIndex: 3] boolValue];
	//NSArray *zoneIds = [command.arguments objectAtIndex:4];	
    //NSLog(@"%@", adUnitBanner);
    //NSLog(@"%@", adUnitInterstitial);
    //NSLog(@"%d", isOverlap);
    //NSLog(@"%d", isTest);
	NSString* appId = [command.arguments objectAtIndex:0];
	NSString* interstitialAdZoneId = [command.arguments objectAtIndex:1];
	NSString* rewardedVideoAdZoneId = [command.arguments objectAtIndex:2];
	NSLog(@"%@", appId);
	NSLog(@"%@", interstitialAdZoneId);
	NSLog(@"%@", rewardedVideoAdZoneId);
	
    self.callbackIdKeepCallback = command.callbackId;
	
    //[self.commandDelegate runInBackground:^{
		[self _setUp:appId aInterstitialAdZoneId:interstitialAdZoneId aRewardedVideoAdZoneId:rewardedVideoAdZoneId];	
    //}];
}

- (void) showInterstitialAd: (CDVInvokedUrlCommand*)command {

    [self.commandDelegate runInBackground:^{
		[self _showInterstitialAd];
    }];
}

- (void) showRewardedVideoAd: (CDVInvokedUrlCommand*)command {

    [self.commandDelegate runInBackground:^{
		[self _showRewardedVideoAd];
    }];
}

- (void) _setLicenseKey:(NSString *)email aLicenseKey:(NSString *)licenseKey {
	self.email = email;
	self.licenseKey_ = licenseKey;
	
	//
	NSString *str1 = [self md5:[NSString stringWithFormat:@"cordova-plugin-: %@", email]];
	NSString *str2 = [self md5:[NSString stringWithFormat:@"cordova-plugin-ad-adcolony: %@", email]];
	NSString *str3 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.: %@", email]];
	NSString *str4 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.ad.adcolony: %@", email]];
	NSString *str5 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.ad.video.adcolony: %@", email]];
	if(licenseKey_ != Nil && ([licenseKey_ isEqualToString:str1] || [licenseKey_ isEqualToString:str2] || [licenseKey_ isEqualToString:str3] || [licenseKey_ isEqualToString:str4] || [licenseKey_ isEqualToString:str5])){
		self.validLicenseKey = YES;
		NSArray *excludedLicenseKeys = [NSArray arrayWithObjects: @"xxx", nil];
		for (int i = 0 ; i < [excludedLicenseKeys count] ; i++) {
			if([[excludedLicenseKeys objectAtIndex:i] isEqualToString:licenseKey]) {
				self.validLicenseKey = NO;
				break;
			}
		}
	}
	else {
		self.validLicenseKey = NO;
	}
	if (self.validLicenseKey)
		NSLog(@"valid licenseKey");
	else {
		NSLog(@"invalid licenseKey");
		//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Cordova AdColony: invalid email / license key. You can get free license key from https://play.google.com/store/apps/details?id=com.cranberrygame.pluginsforcordova" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[alert show];
	}
}

- (NSString*) md5:(NSString*) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (void) _setUp:(NSString *)appId aInterstitialAdZoneId:(NSString *)interstitialAdZoneId aRewardedVideoAdZoneId:(NSString *)rewardedVideoAdZoneId {
	self.appId = appId;
	self.interstitialAdZoneId = interstitialAdZoneId;
	self.rewardedVideoAdZoneId = rewardedVideoAdZoneId;

	if (!validLicenseKey) {
		if (arc4random() % 100 <= 1) {//0 ~ 99		
			self.appId = TEST_APP_ID;
			self.interstitialAdZoneId = TEST_INTERSTITIAL_AD_ZONE_ID;
			self.rewardedVideoAdZoneId = TEST_REWARDED_VIDEO_AD_ZONE_ID;
		}
	}
	
	//
    BOOL debug = NO;
/*
	NSDictionary *options = [command.arguments objectAtIndex:2];
	if (options && [options isKindOfClass:[NSDictionary class]]) {
		[AdColony setCustomID:[options objectForKey:@"customId"]];
		debug = [self toBool:[options objectForKey:@"debug"]];
	}
*/	

	NSArray* zoneIds = [NSArray arrayWithObjects: self.interstitialAdZoneId, self.rewardedVideoAdZoneId, nil];
	
	//+ ( void ) configureWithAppID:( NSString * )appID zoneIDs:( NSArray * )zoneIDs delegate:( id<AdColonyDelegate> )del logging:( BOOL )log;
	[AdColony configureWithAppID:self.appId 
		zoneIDs:zoneIds
		delegate:[[MyAdColonyDelegate alloc] initWithAdColonyPlugin:self]
		logging:debug
	];
}

-(void) _showinterstitialAd {

    if (![AdColony videoAdCurrentlyRunning]) {
		//+ ( void ) playVideoAdForZone:( NSString * )zoneID withDelegate:( id<AdColonyAdDelegate> )del;
        [AdColony playVideoAdForZone:interstitialAdZoneId 
			withDelegate:[[AdColonyAdDelegateInterstitialAd alloc] initWithAdColonyPlugin:self]
		];
    }	
}

-(void) _showRewardedVideoAd {

    if (![AdColony videoAdCurrentlyRunning]) {
		//+ ( void ) playVideoAdForZone:( NSString * )zoneID withDelegate:( id<AdColonyAdDelegate> )del withV4VCPrePopup:( BOOL )showPrePopup andV4VCPostPopup:( BOOL )showPostPopup;
        [AdColony playVideoAdForZone:rewardedVideoAdZoneId
			withDelegate:[[AdColonyAdDelegateRewardedVideoAd alloc] initWithAdColonyPlugin:self]
			//withV4VCPrePopup:YES 
			//andV4VCPostPopup:YES
		];
    }
}

@end

@implementation MyAdColonyDelegate

@synthesize adColonyPlugin;

- (id) initWithAdColonyPlugin:(AdColonyPlugin *)adColonyPlugin_ {
    self = [super init];
    if (self) {
        self.adColonyPlugin = adColonyPlugin_;
    }
    return self;
}	

- (void)onAdColonyAdAvailabilityChange:(BOOL)available inZone:(NSString *)zoneId {
	NSLog(@"%@: %d", @"onAdColonyAdAvailabilityChange", available);
	
	if (available) {	
        if ([zoneId isEqualToString:self.adColonyPlugin.interstitialAdZoneId]) {
			CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onInterstitialAdLoaded"];
			[pr setKeepCallbackAsBool:YES];
			[adColonyPlugin.commandDelegate sendPluginResult:pr callbackId:adColonyPlugin.callbackIdKeepCallback];
			//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
			//[pr setKeepCallbackAsBool:YES];
			//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];			
		}
        else if ([zoneId isEqualToString:self.adColonyPlugin.rewardedVideoAdZoneId]) {
			CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdLoaded"];
			[pr setKeepCallbackAsBool:YES];
			[adColonyPlugin.commandDelegate sendPluginResult:pr callbackId:adColonyPlugin.callbackIdKeepCallback];
			//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
			//[pr setKeepCallbackAsBool:YES];
			//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];	
		}		
	}
}

- (void)onAdColonyV4VCReward:(BOOL)success currencyName:(NSString *)currencyName currencyAmount:(int)amount inZone:(NSString *)zoneId {
	NSLog(@"%@ %d", @"onAdColonyV4VCReward", success);

    if (success) {
    	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdCompleted"];
		[pr setKeepCallbackAsBool:YES];
		[adColonyPlugin.commandDelegate sendPluginResult:pr callbackId:adColonyPlugin.callbackIdKeepCallback];
		//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
		//[pr setKeepCallbackAsBool:YES];
		//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
    } 
}

@end

@implementation AdColonyAdDelegateInterstitialAd

@synthesize adColonyPlugin;

- (id) initWithAdColonyPlugin:(AdColonyPlugin *)adColonyPlugin_ {
    self = [super init];
    if (self) {
        self.adColonyPlugin = adColonyPlugin_;
    }
    return self;
}

- (void)onAdColonyAdStartedInZone:(NSString *)zoneId {
	NSLog(@"%@", @"onAdColonyAdStartedInZone");

	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onInterstitialAdShown"];
	[pr setKeepCallbackAsBool:YES];
	[adColonyPlugin.commandDelegate sendPluginResult:pr callbackId:adColonyPlugin.callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
}

- (void)onAdColonyAdAttemptFinished:(BOOL)shown inZone:(NSString *)zoneId {
	NSLog(@"%@", @"onAdColonyAdAttemptFinished");
	
    if (shown) {
		NSLog(@"%@", @"onAdColonyAdAttemptFinished: shown");
	
		CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onInterstitialAdHidden"];
		[pr setKeepCallbackAsBool:YES];
		[adColonyPlugin.commandDelegate sendPluginResult:pr callbackId:adColonyPlugin.callbackIdKeepCallback];
		//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
		//[pr setKeepCallbackAsBool:YES];
		//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
    } 
	else {
		NSLog(@"%@", @"onAdColonyAdAttemptFinished: else");
    }
}

@end

@implementation AdColonyAdDelegateRewardedVideoAd

@synthesize adColonyPlugin;

- (id) initWithAdColonyPlugin:(AdColonyPlugin *)adColonyPlugin_ {
    self = [super init];
    if (self) {
        self.adColonyPlugin = adColonyPlugin_;
    }
    return self;
}

- (void)onAdColonyAdStartedInZone:(NSString *)zoneId
{
	NSLog(@"%@", @"onAdColonyAdStartedInZone");

	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdShown"];
	[pr setKeepCallbackAsBool:YES];
	[adColonyPlugin.commandDelegate sendPluginResult:pr callbackId:adColonyPlugin.callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
}

- (void)onAdColonyAdAttemptFinished:(BOOL)shown inZone:(NSString *)zoneId {
	NSLog(@"%@", @"onAdColonyAdAttemptFinished");
	
    if (shown) {
		NSLog(@"%@", @"onAdColonyAdAttemptFinished: shown");
	
		CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdHidden"];
		[pr setKeepCallbackAsBool:YES];
		[adColonyPlugin.commandDelegate sendPluginResult:pr callbackId:adColonyPlugin.callbackIdKeepCallback];
		//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
		//[pr setKeepCallbackAsBool:YES];
		//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
    } 
	else {
		NSLog(@"%@", @"onAdColonyAdAttemptFinished: else");
    }
}

@end
