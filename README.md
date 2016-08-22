Cordova AdColony plugin
====================
# Overview #
Show adcolony full screen ad and rewarded video ad

[android, ios] [cordova cli] [xdk] [cocoon] [phonegap build service]

Requires adcolony account http://www.adcolony.com/

AdColony Android SDK Version: 2.2.1 (Modified: 2014/2/10)
AdColony iOS SDK Version: 2.5.3 (Modified: 2015/07/22)

This is open source cordova plugin.

You can see Cordova Plugins in one page: http://cranberrygame.github.io?referrer=github

# Change log #
	2016.1.22
	updated AdColony iOS SDK Version: 2.5.3
```c
```
# Install plugin #

## Cordova cli ##
https://cordova.apache.org/docs/en/edge/guide_cli_index.md.html#The%20Command-Line%20Interface - npm install -g cordova@6.0.0
```c
cordova plugin add cordova-plugin-ad-adcolony
(when build error, use github url: cordova plugin add cordova plugin add https://github.com/cranberrygame/cordova-plugin-ad-adcolony)
```

## Xdk ##
https://software.intel.com/en-us/intel-xdk - Download XDK - XDK PORJECTS - [specific project] - CORDOVA HYBRID MOBILE APP SETTINGS - Plugin Management - Add Plugins to this Project - Third Party Plugins -
```c
Plugin Source: Cordova plugin registry
Plugin ID: cordova-plugin-ad-adcolony
```

## Cocoon ##
https://cocoon.io - Create project - [specific project] - Setting - Plugins - Custom - Git Url: https://github.com/cranberrygame/cordova-plugin-ad-adcolony.git - INSTALL - Save<br>

## Phonegap build service (config.xml) ##
https://build.phonegap.com/ - Apps - [specific project] - Update code - Zip file including config.xml
```c
<gap:plugin name="cordova-plugin-ad-adcolony" source="npm" />
```

## Construct2 ##
Download construct2 plugin<br>
https://dl.dropboxusercontent.com/u/186681453/pluginsforcordova/index.html<br>
How to install c2 native plugins in xdk, cocoon and cordova cli<br>
https://plus.google.com/102658703990850475314/posts/XS5jjEApJYV

# Server setting #
```c
```

<img src="https://raw.githubusercontent.com/cranberrygame/cordova-plugin-ad-adcolony/master/doc/app_id1.png"><br>
<img src="https://raw.githubusercontent.com/cranberrygame/cordova-plugin-ad-adcolony/master/doc/app_id2.png"><br>
<img src="https://raw.githubusercontent.com/cranberrygame/cordova-plugin-ad-adcolony/master/doc/app_id3.png"><br>
<img src="https://raw.githubusercontent.com/cranberrygame/cordova-plugin-ad-adcolony/master/doc/app_id4.png"><br>
<img src="https://raw.githubusercontent.com/cranberrygame/cordova-plugin-ad-adcolony/master/doc/app_id5.png"><br>
<img src="https://raw.githubusercontent.com/cranberrygame/cordova-plugin-ad-adcolony/master/doc/app_id6.png"><br>
<img src="https://raw.githubusercontent.com/cranberrygame/cordova-plugin-ad-adcolony/master/doc/app_id7.png">

test mode setting: 
http://www.adcolony.com/ - Login - MONETISATION - [specific app] -[specific zone] - Development - Show test ads only (for dev or debug)? Yes No

# API #
```javascript
var appId = "REPLACE_THIS_WITH_YOUR_APP_ID";
var InterstitialAdZoneId = "REPLACE_THIS_WITH_YOUR_INTERSTITIAL_AD_ZONE_ID";
var rewardedVideoAdZoneId = "REPLACE_THIS_WITH_YOUR_REWARDED_VIDEO_AD_ZONE_ID";
/*
var appId;
var interstitialAdZoneId;
var rewardedVideoAdZoneId;
//android
if (navigator.userAgent.match(/Android/i)) {
	appId = "REPLACE_THIS_WITH_YOUR_APP_ID";
	interstitialAdZoneId = "REPLACE_THIS_WITH_YOUR_INTERSTITIAL_AD_ZONE_ID";
	rewardedVideoAdZoneId = "REPLACE_THIS_WITH_YOUR_REWARDED_VIDEO_AD_ZONE_ID";
}
//ios
else if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
	appId = "REPLACE_THIS_WITH_YOUR_APP_ID";
	interstitialAdZoneId = "REPLACE_THIS_WITH_YOUR_INTERSTITIAL_AD_ZONE_ID";
	rewardedVideoAdZoneId = "REPLACE_THIS_WITH_YOUR_REWARDED_VIDEO_AD_ZONE_ID";
}
*/

document.addEventListener("deviceready", function(){
	//if no license key, 2% ad traffic share for dev support.
	//you can get paid license key: https://cranberrygame.github.io/request_cordova_ad_plugin_paid_license_key
	//window.adcolony.setLicenseKey("yourEmailId@yourEmaildDamin.com", "yourLicenseKey");

	window.adcolony.setUp(appId, interstitialAdZoneId, rewardedVideoAdZoneId);
	
	//
	window.adcolony.onInterstitialAdLoaded = function() {
		alert('onInterstitialAdLoaded');
	};	
	window.adcolony.onInterstitialAdShown = function() {
		alert('onInterstitialAdShown');
	};
	window.adcolony.onInterstitialAdHidden = function() {
		alert('onInterstitialAdHidden');
	};
	//
	window.adcolony.onRewardedVideoAdLoaded = function() {
		alert('onRewardedVideoAdLoaded');
	};	
	window.adcolony.onRewardedVideoAdShown = function() {
		alert('onRewardedVideoAdShown');
	};
	window.adcolony.onRewardedVideoAdHidden = function() {
		alert('onRewardedVideoAdHidden');
	};	
	window.adcolony.onRewardedVideoAdCompleted = function() {
		alert('onRewardedVideoAdCompleted');
	};
}, false);

window.adcolony.showInterstitialAd();

window.adcolony.showRewardedVideoAd();

alert(window.adcolony.loadedInterstitialAd());//boolean: true or false
alert(window.adcolony.loadedRewardedVideoAd());//boolean: true or false

alert(window.adcolony.isShowingInterstitialAd());//boolean: true or false
alert(window.adcolony.isShowingRewardedVideoAd());//boolean: true or false
```
# Examples #
<a href="https://github.com/cranberrygame/cordova-plugin-ad-adcolony/blob/master/example/basic/index.html">example/basic/index.html</a><br>

# Test #

[![](http://img.youtube.com/vi/ublL50r5PW4/0.jpg)](https://www.youtube.com/watch?v=ublL50r5PW4&feature=youtu.be "Youtube")

You can also run following test apk.
https://dl.dropboxusercontent.com/u/186681453/pluginsforcordova/adcolony/apk.html

# Useful links #

Cordova Plugins<br>
http://cranberrygame.github.io?referrer=github

# Credits #
