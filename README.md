Cordova AdColony plugin
====================
# Overview #
Show adcolony full screen ad and rewarded video ad

[android, ios] [cordova cli] [xdk]

Requires adcolony account http://www.adcolony.com/

AdColony Android SDK Version: 2.2.1 (Modified: February 10, 2014)
AdColony iOS SDK Version: 2.5.0 (Modified: 2015/02/04)

This is open source cordova plugin.

You can see Plugins For Cordova in one page: http://cranberrygame.github.io?referrer=github

# Change log #
```c
```
# Install plugin #

## Cordova cli ##
```c
cordova plugin add com.cranberrygame.cordova.plugin.ad.video.adcolony
```

## Xdk ##
```c
XDK PORJECTS - your_xdk_project - CORDOVA 3.X HYBRID MOBILE APP SETTINGS - PLUGINS AND PERMISSIONS - Third Party Plugins - Add a Third Party Plugin - Get Plugin from the Web -

Name: revmob
Plugin ID: com.cranberrygame.cordova.plugin.ad.video.adcolony
[v] Plugin is located in the Apache Cordova Plugins Registry
```

## Phonegap build service (config.xml) ##
```c
<gap:plugin name="com.cranberrygame.cordova.plugin.ad.video.adcolony" source="plugins.cordova.io" />
```

## Construct2 ##
Download construct2 plugin: https://dl.dropboxusercontent.com/u/186681453/pluginsforcordova/adcolony/construct2.html
<br>
Now all the native plugins are installed automatically: https://plus.google.com/102658703990850475314/posts/XS5jjEApJYV
# Server setting #
```c
```

<img src="https://github.com/cranberrygame/cordova-plugin-ad-video-adcolony/blob/master/doc/app_id1.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-video-adcolony/blob/master/doc/app_id2.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-video-adcolony/blob/master/doc/app_id3.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-video-adcolony/blob/master/doc/app_id4.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-video-adcolony/blob/master/doc/app_id5.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-video-adcolony/blob/master/doc/app_id6.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-video-adcolony/blob/master/doc/app_id7.png">

test mode setting: 
http://www.adcolony.com/ - Login - MONETISATION - [specific app] -[specific zone] - Development - Show test ads only (for dev or debug)? Yes No

# API #
```javascript
var appId = "REPLACE_THIS_WITH_YOUR_APP_ID";

/*
var appId;
//android
if (navigator.userAgent.match(/Android/i)) {
	appId = "REPLACE_THIS_WITH_YOUR_APP_ID";
}
//ios
else if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
	appId = "REPLACE_THIS_WITH_YOUR_APP_ID";
}
*/

document.addEventListener("deviceready", function(){
	//if no license key, 2% ad traffic share for dev support.
	//you can get free license key from https://play.google.com/store/apps/details?id=com.cranberrygame.pluginsforcordova
	//window.adcolony.setLicenseKey("yourEmailId@yourEmaildDamin.com", "yourFreeLicenseKey");

	window.adcolony.setUp(appId, "REPLACE_THIS_WITH_YOUR_ZONE_ID"); //zoneIds: ex1) "vz06e8c32a037749699e7050" ex2) "vz06e8c32a037749699e7050,vz1fd5a8b2bf6841a0a4b826"
	
	//
	window.adcolony.onFullScreenAdShown = function() {
		alert('onFullScreenAdShown');
	};
	window.adcolony.onFullScreenAdHidden = function() {
		alert('onFullScreenAdHidden');
	};
	//
	window.adcolony.onRewardedVideoAdShown = function() {
		alert('onRewardedVideoAdShown');
	};
	window.adcolony.onRewardedVideoAdHidden = function() {
		alert('onRewardedVideoAdHidden');
	};	
	window.adcolony.onRewardedVideoAdCompleted = function() {
		alert('onRewardedVideoAdCompleted');
	};
	window.adcolony.onRewardedVideoAdNotCompleted = function() {
		alert('onRewardedVideoAdNotCompleted');
	};
}, false);

window.adcolony.showFullScreenAd('REPLACE_THIS_WITH_YOUR_ZONE_ID');

window.adcolony.showRewardedVideoAd('REPLACE_THIS_WITH_YOUR_ZONE_ID');

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
