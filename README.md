Cordova AdColony plugin
====================
# Overview #
Show adcolony full screen ad and rewarded video ad

[android, ios] [cordova cli] [xdk]

Requires adcolony account http://www.adcolony.com/

AdColony Android SDK Version: 2.2.1 (Modified: 2014/2/10)
AdColony iOS SDK Version: 2.5.1 (Modified: 2015/05/18)

This is open source cordova plugin.

You can see Plugins For Cordova in one page: http://cranberrygame.github.io?referrer=github

# Change log #
```c
```
# Install plugin #

## Cordova cli ##
https://cordova.apache.org/docs/en/edge/guide_cli_index.md.html#The%20Command-Line%20Interface - npm install -g cordova@4.1.2
```c
cordova plugin add com.cranberrygame.cordova.plugin.ad.adcolony
```

## Xdk ##
https://software.intel.com/en-us/intel-xdk - Download XDK - XDK PORJECTS - [specific project] - CORDOVA 3.X HYBRID MOBILE APP SETTINGS - PLUGINS - Third Party Plugins - Add a Third Party Plugin - Get Plugin from the Web -
```c
Name: adcolony
Plugin ID: com.cranberrygame.cordova.plugin.ad.adcolony
[v] Plugin is located in the Apache Cordova Plugins Registry
```

## Cocoon ##
https://cocoon.io - Create project - [specific project] - Setting - Plugins - Custom - Git Url: https://github.com/cranberrygame/cordova-plugin-ad-adcolony.git - INSTALL - Save<br>

## Phonegap build service (config.xml) ##
https://build.phonegap.com/ - Apps - [specific project] - Update code - Zip file including config.xml
```c
<gap:plugin name="com.cranberrygame.cordova.plugin.ad.adcolony" source="plugins.cordova.io" />
```

## Construct2 ##
Download construct2 plugin: http://www.paywithapost.de/pay?id=4ef3f2be-26e8-4a04-b826-6680db13a8c8
<br>
Now all the native plugins are installed automatically: https://plus.google.com/102658703990850475314/posts/XS5jjEApJYV
# Server setting #
```c
```

<img src="https://github.com/cranberrygame/cordova-plugin-ad-adcolony/blob/master/doc/app_id1.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-adcolony/blob/master/doc/app_id2.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-adcolony/blob/master/doc/app_id3.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-adcolony/blob/master/doc/app_id4.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-adcolony/blob/master/doc/app_id5.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-adcolony/blob/master/doc/app_id6.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-adcolony/blob/master/doc/app_id7.png">

test mode setting: 
http://www.adcolony.com/ - Login - MONETISATION - [specific app] -[specific zone] - Development - Show test ads only (for dev or debug)? Yes No

# API #
```javascript
var appId = "REPLACE_THIS_WITH_YOUR_APP_ID";
var fullScreenAdZoneId = "REPLACE_THIS_WITH_YOUR_FULL_SCREEN_AD_ZONE_ID";
var rewardedVideoAdZoneId = "REPLACE_THIS_WITH_YOUR_REWARDED_VIDEO_AD_ZONE_ID";
/*
var appId;
var fullScreenAdZoneId;
var rewardedVideoAdZoneId;
//android
if (navigator.userAgent.match(/Android/i)) {
	appId = "REPLACE_THIS_WITH_YOUR_APP_ID";
	fullScreenAdZoneId = "REPLACE_THIS_WITH_YOUR_FULL_SCREEN_AD_ZONE_ID";
	rewardedVideoAdZoneId = "REPLACE_THIS_WITH_YOUR_REWARDED_VIDEO_AD_ZONE_ID";
}
//ios
else if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
	appId = "REPLACE_THIS_WITH_YOUR_APP_ID";
	fullScreenAdZoneId = "REPLACE_THIS_WITH_YOUR_FULL_SCREEN_AD_ZONE_ID";
	rewardedVideoAdZoneId = "REPLACE_THIS_WITH_YOUR_REWARDED_VIDEO_AD_ZONE_ID";
}
*/

document.addEventListener("deviceready", function(){
	//if no license key, 2% ad traffic share for dev support.
	//you can get free license key from https://play.google.com/store/apps/details?id=com.cranberrygame.pluginsforcordova
	//window.adcolony.setLicenseKey("yourEmailId@yourEmaildDamin.com", "yourFreeLicenseKey");

	window.adcolony.setUp(appId, fullScreenAdZoneId, rewardedVideoAdZoneId);
	
	//
	window.adcolony.onFullScreenAdLoaded = function() {
		alert('onFullScreenAdLoaded');
	};	
	window.adcolony.onFullScreenAdShown = function() {
		alert('onFullScreenAdShown');
	};
	window.adcolony.onFullScreenAdHidden = function() {
		alert('onFullScreenAdHidden');
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

window.adcolony.showFullScreenAd();

window.adcolony.showRewardedVideoAd();

alert(window.adcolony.loadedFullScreenAd());//boolean: true or false
alert(window.adcolony.loadedRewardedVideoAd());//boolean: true or false

alert(window.adcolony.isShowingFullScreenAd());//boolean: true or false
alert(window.adcolony.isShowingRewardedVideoAd());//boolean: true or false
```
# Examples #
<a href="https://github.com/cranberrygame/cordova-plugin-ad-adcolony/blob/master/example/basic/index.html">example/basic/index.html</a><br>

# Test #

[![](http://img.youtube.com/vi/ublL50r5PW4/0.jpg)](https://www.youtube.com/watch?v=ublL50r5PW4&feature=youtu.be "Youtube")

You can also run following test apk.
https://dl.dropboxusercontent.com/u/186681453/pluginsforcordova/adcolony/apk.html

# Useful links #

Plugins For Cordova<br>
http://cranberrygame.github.io?referrer=github

# Credits #
