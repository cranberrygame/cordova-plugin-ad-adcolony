
module.exports = {
	_loadedFullScreenAd: false,
	_loadedRewardedVideoAd: false,
	_isShowingFullScreenAd: false,
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
	setUp: function(appId, fullScreenAdZoneId, rewardedVideoAdZoneId) {
		var self = this;	
        cordova.exec(
			function (result) {
				console.log('setUp succeeded.');
				
				if (typeof result == "string") {
					//
					if (result == "onFullScreenAdLoaded") {
						self._loadedFullScreenAd = true;

						if (self.onFullScreenAdLoaded)
							self.onFullScreenAdLoaded();
					}					
					if (result == "onFullScreenAdShown") {
						self._loadedFullScreenAd = false;
						self._isShowingFullScreenAd = true;
					
						if (self.onFullScreenAdShown)
							self.onFullScreenAdShown();
					}
					else if (result == "onFullScreenAdHidden") {
						self._isShowingFullScreenAd = false;
					
						 if (self.onFullScreenAdHidden)
							self.onFullScreenAdHidden();
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
			[appId, fullScreenAdZoneId, rewardedVideoAdZoneId]
        ); 
    },
    showFullScreenAd: function() {
		cordova.exec(
 			null,
            null,
            'AdColonyPlugin',
            'showFullScreenAd',
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
	loadedFullScreenAd: function() {
		return this._loadedFullScreenAd;
	},
	loadedRewardedVideoAd: function() {
		return this._loadedRewardedVideoAd;
	},
	isShowingFullScreenAd: function() {
		return this._isShowingFullScreenAd;
	},
	isShowingRewardedVideoAd: function() {
		return this._isShowingRewardedVideoAd;
	},
	onFullScreenAdLoaded: null,
	onFullScreenAdShown: null,
	onFullScreenAdHidden: null,	
	//
	onRewardedVideoAdLoaded: null,
	onRewardedVideoAdShown: null,
	onRewardedVideoAdHidden: null,
	onRewardedVideoAdCompleted: null
};
