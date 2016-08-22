
module.exports = {
	_loadedInterstitialAd: false,
	_loadedRewardedVideoAd: false,
	_isShowingInterstitialAd: false,
	_isShowingRewardedVideoAd: false,
	//
	setLicenseKey: function(email, licenseKey) {
		var self = this;	
        cordova.exec(
            null,
            null,
            'AdColonyPlugin',
            'setLicenseKey',			
            [email, licenseKey]
        ); 
    },
	setUp: function(appId, InterstitialAdZoneId, rewardedVideoAdZoneId) {
		var self = this;	
        cordova.exec(
			function (result) {
				console.log('setUp succeeded.');
				
				if (typeof result == "string") {
					//
					if (result == "onInterstitialAdLoaded") {
						self._loadedInterstitialAd = true;
//cranberrygame start; deprecated
						if (self.onFullScreenAdLoaded)
							self.onFullScreenAdLoaded();
//cranberrygame end						
						if (self.onInterstitialAdLoaded)
							self.onInterstitialAdLoaded();
					}					
					else if (result == "onInterstitialAdShown") {
						self._loadedInterstitialAd = false;
						self._isShowingInterstitialAd = true;

//cranberrygame start; deprecated						
						if (self.onFullScreenAdShown)
							self.onFullScreenAdShown();	
//cranberrygame end
						if (self.onInterstitialAdShown)
							self.onInterstitialAdShown();
					}
					else if (result == "onInterstitialAdHidden") {
						self._isShowingInterstitialAd = false;
					
//cranberrygame start; deprecated					
						 if (self.onFullScreenAdHidden)
							self.onFullScreenAdHidden();
//cranberrygame end							
						 if (self.onInterstitialAdHidden)
							self.onInterstitialAdHidden();
					}
					//
					else if (result == "onRewardedVideoAdLoaded") {
						self._loadedRewardedVideoAd = true;

						if (self.onRewardedVideoAdLoaded)
							self.onRewardedVideoAdLoaded();
					}					
					else if (result == "onRewardedVideoAdShown") {
						self._loadedRewardedVideoAd = false;
						self._isShowingRewardedVideoAd = true;
					
						if (self.onRewardedVideoAdShown)
							self.onRewardedVideoAdShown();
					}
					else if (result == "onRewardedVideoAdHidden") {
						self._isShowingRewardedVideoAd = false;
					
						 if (self.onRewardedVideoAdHidden)
							self.onRewardedVideoAdHidden();
					}
					else if (result == "onRewardedVideoAdCompleted") {
						if (self.onRewardedVideoAdCompleted)
							self.onRewardedVideoAdCompleted();
					}
				}
				else {
					//var event = result["event"];
					//var location = result["message"];				
					//if (event == "onXXX") {
					//	if (self.onXXX)
					//		self.onXXX(location);
					//}
				}
			},
			function (error) {
				console.log('setUp failed.');
			},
            'AdColonyPlugin',
            'setUp',			
			[appId, InterstitialAdZoneId, rewardedVideoAdZoneId]
        ); 
    },
//cranberrygame start; deprecated
    showFullScreenAd: function() {
		cordova.exec(
 			null,
            null,
            'AdColonyPlugin',
            'showFullScreenAd',
            []
        ); 
    },
//cranberrygame end
    showInterstitialAd: function() {
		cordova.exec(
 			null,
            null,
            'AdColonyPlugin',
            'showInterstitialAd',
            []
        ); 
    },
    showRewardedVideoAd: function() {
		cordova.exec(
			null,
            null,
            'AdColonyPlugin',
            'showRewardedVideoAd',
            []
        ); 
    },
//cranberrygame start; deprecated	
	loadedFullScreenAd: function() {
		return this._loadedInterstitialAd;
	},
//cranberrygame end	
	loadedInterstitialAd: function() {
		return this._loadedInterstitialAd;
	},
	loadedRewardedVideoAd: function() {
		return this._loadedRewardedVideoAd;
	},
//cranberrygame start; deprecated	
	isShowingFullScreenAd: function() {
		return this._isShowingInterstitialAd;
	},
//cranberrygame end	
	isShowingInterstitialAd: function() {
		return this._isShowingInterstitialAd;
	},
	isShowingRewardedVideoAd: function() {
		return this._isShowingRewardedVideoAd;
	},
//cranberrygame start; deprecated
	onFullScreenAdLoaded: null,
	onFullScreenAdShown: null,
	onFullScreenAdHidden: null,	
//cranberrygame end	
	onInterstitialAdLoaded: null,
	onInterstitialAdShown: null,
	onInterstitialAdHidden: null,	
	//
	onRewardedVideoAdLoaded: null,
	onRewardedVideoAdShown: null,
	onRewardedVideoAdHidden: null,
	onRewardedVideoAdCompleted: null
};
