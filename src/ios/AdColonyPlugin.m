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
static NSString *TEST_ZONE_ID_FULL_SCREEN_AD = @"vzc77c6ffd0b924e0283";
static NSString *TEST_ZONE_ID_REWARDED_VIDEO_AD = @"vzac89782a8e01437fbf";
//
@synthesize appId;

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
    //NSString *adUnitFullScreen = [command.arguments objectAtIndex: 1];
    //BOOL isOverlap = [[command.arguments objectAtIndex: 2] boolValue];
    //BOOL isTest = [[command.arguments objectAtIndex: 3] boolValue];
	//NSArray *zoneIds = [command.arguments objectAtIndex:4];	
    //NSLog(@"%@", adUnitBanner);
    //NSLog(@"%@", adUnitFullScreen);
    //NSLog(@"%d", isOverlap);
    //NSLog(@"%d", isTest);
	NSString* appId = [command.arguments objectAtIndex:0];
	NSArray *zoneIds = [command.arguments objectAtIndex:1];
	NSLog(@"%@", appId);
	
    self.callbackIdKeepCallback = command.callbackId;
	
    //[self.commandDelegate runInBackground:^{
		[self _setUp:appId zoneIds:zoneIds];	
    //}];
}

- (void) showFullScreenAd: (CDVInvokedUrlCommand*)command {
	NSString* zoneId = [command.arguments objectAtIndex:0];
	NSLog(@"%@", zoneId);

    [self.commandDelegate runInBackground:^{
		[self _showFullScreenAd:zoneId];
    }];
}

- (void) showRewardedVideoAd: (CDVInvokedUrlCommand*)command {
	NSString* zoneId = [command.arguments objectAtIndex:0];
	NSLog(@"%@", zoneId);

    [self.commandDelegate runInBackground:^{
		[self _showRewardedVideoAd:zoneId];
    }];
}

- (void) _setLicenseKey:(NSString *)email aLicenseKey:(NSString *)licenseKey {
	self.email = email;
	self.licenseKey_ = licenseKey;
	
	//
	NSString *str1 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.: %@", email]];
	NSString *str2 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.ad.adcolony: %@", email]];
	NSString *str3 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.ad.video.adcolony: %@", email]];
	if(licenseKey_ != Nil && ([licenseKey_ isEqualToString:str1] || [licenseKey_ isEqualToString:str2] || [licenseKey_ isEqualToString:str3])){
		self.validLicenseKey = YES;
		NSArray *excludedLicenseKeys = [NSArray arrayWithObjects: @"995f68522b89ea504577d93232db608c", nil];
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

- (void) _setUp:(NSString *)appId zoneIds:(NSArray *)zoneIds {
	self.appId = appId;

	if (!validLicenseKey) {
		if (arc4random() % 100 <= 1) {//0 ~ 99		
			self.appId = TEST_APP_ID;
            zoneIds = [NSArray arrayWithObjects: TEST_ZONE_ID_FULL_SCREEN_AD, TEST_ZONE_ID_REWARDED_VIDEO_AD, nil];
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
	//+ ( void ) configureWithAppID:( NSString * )appID zoneIDs:( NSArray * )zoneIDs delegate:( id<AdColonyDelegate> )del logging:( BOOL )log;
	[AdColony configureWithAppID:self.appId 
		zoneIDs:zoneIds
		delegate:[[MyAdColonyDelegate alloc] initWithAdColonyPlugin:self]
		logging:debug
	];
}

-(void) _showFullScreenAd:(NSString *)zoneId {
	if ([appId isEqualToString:TEST_APP_ID]) {
		zoneId = TEST_ZONE_ID_FULL_SCREEN_AD;
	}

    if (![AdColony videoAdCurrentlyRunning]) {
		//+ ( void ) playVideoAdForZone:( NSString * )zoneID withDelegate:( id<AdColonyAdDelegate> )del;
        [AdColony playVideoAdForZone:zoneId 
			withDelegate:[[AdColonyAdDelegateFullScreenAd alloc] initWithAdColonyPlugin:self]
		];
    }	
}

-(void) _showRewardedVideoAd:(NSString *)zoneId {
	if ([appId isEqualToString:TEST_APP_ID]) {
		zoneId = TEST_ZONE_ID_REWARDED_VIDEO_AD;
	}

    if (![AdColony videoAdCurrentlyRunning]) {
		//+ ( void ) playVideoAdForZone:( NSString * )zoneID withDelegate:( id<AdColonyAdDelegate> )del withV4VCPrePopup:( BOOL )showPrePopup andV4VCPostPopup:( BOOL )showPostPopup;
        [AdColony playVideoAdForZone:zoneId
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

@implementation AdColonyAdDelegateFullScreenAd

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

	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onFullScreenAdShown"];
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
	
		CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onFullScreenAdHidden"];
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
