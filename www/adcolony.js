
module.exports = {
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
	setUp: function(appId, zoneIds) {
		var zoneIdsArr = zoneIds.split(",");			
		for (var i = 0 ; i < zoneIdsArr.length ; i++) {
			zoneIdsArr[i] = zoneIdsArr[i].trim();			
		}
		
		var self = this;	
        cordova.exec(
			function (result) {
				console.log('setUp succeeded.');
				
				if (typeof result == "string") {
					//
					if (result == "onFullScreenAdShown") {
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
					else if (result == "onRewardedVideoAdShown") {
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
					//if (result["event"] == "onXXX") {
					//	//result["message"]
					//	if (self.onXXX)
					//		self.onXXX(result);
					//}
				}
			},
			function (error) {
				console.log('setUp failed.');
			},
            'AdColonyPlugin',
            'setUp',			
			[appId, zoneIdsArr]
        ); 
    },
    showFullScreenAd: function(zoneId) {
		cordova.exec(
 			null,
            null,
            'AdColonyPlugin',
            'showFullScreenAd',
            [zoneId]
        ); 
    },
    showRewardedVideoAd: function(zoneId) {
		cordova.exec(
			null,
            null,
            'AdColonyPlugin',
            'showRewardedVideoAd',
            [zoneId]
        ); 
    },
	isShowingFullScreenAd: function() {
		return this._isShowingFullScreenAd;
	},
	isShowingRewardedVideoAd: function() {
		return this._isShowingRewardedVideoAd;
	},
	//
	onFullScreenAdShown: null,
	onFullScreenAdHidden: null,	
	//
	onRewardedVideoAdShown: null,
	onRewardedVideoAdHidden: null,
	onRewardedVideoAdCompleted: null
};
