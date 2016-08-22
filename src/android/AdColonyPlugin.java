//Copyright (c) 2014 Sang Ki Kwon (Cranberrygame)
//Email: cranberrygame@yahoo.com
//Homepage: http://cranberrygame.github.io
//License: MIT (http://opensource.org/licenses/MIT)
package com.cranberrygame.cordova.plugin.ad.adcolony;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import android.annotation.TargetApi;
import android.app.Activity;
import android.util.Log;
//
import com.jirbo.adcolony.*;
import org.apache.cordova.PluginResult.Status;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.view.View;
import java.util.Iterator;
//md5
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
//Util
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.view.Surface;
//
import java.util.*;//Random
//
import java.util.HashMap;//HashMap
import java.util.Map;//HashMap

class Util {

	//ex) Util.alert(cordova.getActivity(),"message");
	public static void alert(Activity activity, String message) {
		AlertDialog ad = new AlertDialog.Builder(activity).create();  
		ad.setCancelable(false); // This blocks the 'BACK' button  
		ad.setMessage(message);  
		ad.setButton("OK", new DialogInterface.OnClickListener() {  
			@Override  
			public void onClick(DialogInterface dialog, int which) {  
				dialog.dismiss();                      
			}  
		});  
		ad.show(); 		
	}
	
	//https://gitshell.com/lvxudong/A530_packages_app_Camera/blob/master/src/com/android/camera/Util.java
	public static int getDisplayRotation(Activity activity) {
	    int rotation = activity.getWindowManager().getDefaultDisplay()
	            .getRotation();
	    switch (rotation) {
	        case Surface.ROTATION_0: return 0;
	        case Surface.ROTATION_90: return 90;
	        case Surface.ROTATION_180: return 180;
	        case Surface.ROTATION_270: return 270;
	    }
	    return 0;
	}

	public static final String md5(final String s) {
        try {
            MessageDigest digest = java.security.MessageDigest.getInstance("MD5");
            digest.update(s.getBytes());
            byte messageDigest[] = digest.digest();
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < messageDigest.length; i++) {
                String h = Integer.toHexString(0xFF & messageDigest[i]);
                while (h.length() < 2)
                    h = "0" + h;
                hexString.append(h);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
        }
        return "";
    }
}

public class AdColonyPlugin extends CordovaPlugin {
	private static final String LOG_TAG = "AdColonyPlugin";
	private CallbackContext callbackContextKeepCallback;
	//
	protected String email;
	protected String licenseKey;
	public boolean validLicenseKey;
	protected String TEST_APP_ID = "app873c30909d2a4f8983";
	protected String TEST_INTERSTITIAL_AD_ZONE_ID = "vz8838953078cf4f12aa";
	protected String TEST_REWARDED_VIDEO_AD_ZONE_ID = "vzc6760c29039a4f9fbf";
	//
	protected String appId;
	protected String interstitialAdZoneId;
	protected String rewardedVideoAdZoneId;
	
    @Override
	public void pluginInitialize() {
		super.pluginInitialize();
		//
    }
	
	//@Override
	//public void onCreate(Bundle savedInstanceState) {//build error
	//	super.onCreate(savedInstanceState);
	//	//
	//}
	
	//@Override
	//public void onStart() {//build error
	//	super.onStart();
	//	//
	//}
	
	@Override
	public void onPause(boolean multitasking) {
		super.onPause(multitasking);
		AdColony.pause();
	}
	
	@Override
	public void onResume(boolean multitasking) {
		super.onResume(multitasking);
		AdColony.resume(cordova.getActivity());
	}
	
	//@Override
	//public void onStop() {//build error
	//	super.onStop();
	//	//
	//}
	
	@Override
	public void onDestroy() {
		super.onDestroy();
		//
	}
	
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

		if (action.equals("setLicenseKey")) {
			setLicenseKey(action, args, callbackContext);

			return true;
		}	
		else if (action.equals("setUp")) {
			setUp(action, args, callbackContext);

			return true;
		}			
		else if (action.equals("showInterstitialAd")) {
			showInterstitialAd(action, args, callbackContext);
						
			return true;
		}
		else if (action.equals("showRewardedVideoAd")) {
			showRewardedVideoAd(action, args, callbackContext);
						
			return true;
		}
		
		return false; // Returning false results in a "MethodNotFound" error.
	}

	private void setLicenseKey(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		final String email = args.getString(0);
		final String licenseKey = args.getString(1);				
		Log.d(LOG_TAG, String.format("%s", email));			
		Log.d(LOG_TAG, String.format("%s", licenseKey));
		
		cordova.getActivity().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				_setLicenseKey(email, licenseKey);
			}
		});
	}
	
	private void setUp(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		//Activity activity=cordova.getActivity();
		//webView
		//args.length()
		//args.getString(0)
		//args.getString(1)
		//args.getInt(0)
		//args.getInt(1)
		//args.getBoolean(0)
		//args.getBoolean(1)
		//JSONObject json = args.optJSONObject(0);
		//json.optString("adUnitBanner")
		//json.optString("adUnitInterstitial")
		//JSONObject inJson = json.optJSONObject("inJson");
		//final String adUnitBanner = args.getString(0);
		//final String adUnitInterstitial = args.getString(1);				
		//final boolean isOverlap = args.getBoolean(2);				
		//final boolean isTest = args.getBoolean(3);
		//final String[] zoneIds = new String[args.getJSONArray(4).length()];
		//for (int i = 0; i < args.getJSONArray(4).length(); i++) {
		//	zoneIds[i] = args.getJSONArray(4).getString(i);
		//}			
		//Log.d(LOG_TAG, String.format("%s", adUnitBanner));			
		//Log.d(LOG_TAG, String.format("%s", adUnitInterstitial));
		//Log.d(LOG_TAG, String.format("%b", isOverlap));
		//Log.d(LOG_TAG, String.format("%b", isTest));	
		final String appId = args.getString(0);
		final String interstitialAdZoneId = args.getString(1);
		final String rewardedVideoAdZoneId = args.getString(2);
		Log.d(LOG_TAG, String.format("%s", appId));			
		Log.d(LOG_TAG, String.format("%s", interstitialAdZoneId));			
		Log.d(LOG_TAG, String.format("%s", rewardedVideoAdZoneId));			
		
		callbackContextKeepCallback = callbackContext;
			
		cordova.getActivity().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				_setUp(appId, interstitialAdZoneId, rewardedVideoAdZoneId);
			}
		});
	}
	
	private void showInterstitialAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

		cordova.getActivity().runOnUiThread(new Runnable(){
			@Override
			public void run() {
				_showInterstitialAd();
			}
		});
	}

	private void showRewardedVideoAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

		cordova.getActivity().runOnUiThread(new Runnable(){
			@Override
			public void run() {
				_showRewardedVideoAd();
			}
		});
	}
	
	public void _setLicenseKey(String email, String licenseKey) {
		this.email = email;
		this.licenseKey = licenseKey;
		
		//
		String str1 = Util.md5("cordova-plugin-: " + email);
		String str2 = Util.md5("cordova-plugin-ad-adcolony: " + email);
		String str3 = Util.md5("com.cranberrygame.cordova.plugin.: " + email);
		String str4 = Util.md5("com.cranberrygame.cordova.plugin.ad.adcolony: " + email);
		String str5 = Util.md5("com.cranberrygame.cordova.plugin.ad.video.adcolony: " + email);
		if(licenseKey != null && (licenseKey.equalsIgnoreCase(str1) || licenseKey.equalsIgnoreCase(str2) || licenseKey.equalsIgnoreCase(str3) || licenseKey.equalsIgnoreCase(str4) || licenseKey.equalsIgnoreCase(str5))) {
			this.validLicenseKey = true;
			//
			String[] excludedLicenseKeys = {"xxx"};
			for (int i = 0 ; i < excludedLicenseKeys.length ; i++) {
				if (excludedLicenseKeys[i].equals(licenseKey)) {
					this.validLicenseKey = false;
					break;
				}
			}			
			if (this.validLicenseKey)
				Log.d(LOG_TAG, String.format("%s", "valid licenseKey"));
			else
				Log.d(LOG_TAG, String.format("%s", "invalid licenseKey"));
		}
		else {
			Log.d(LOG_TAG, String.format("%s", "invalid licenseKey"));
			this.validLicenseKey = false;			
		}
		//if (!this.validLicenseKey)
		//	Util.alert(cordova.getActivity(),"Cordova AdColony: invalid email / license key. You can get free license key from https://play.google.com/store/apps/details?id=com.cranberrygame.pluginsforcordova");			
	}
	
	private void _setUp(String appId, String interstitialAdZoneId, String rewardedVideoAdZoneId) {
		this.appId = appId;
		this.interstitialAdZoneId = interstitialAdZoneId;
		this.rewardedVideoAdZoneId = rewardedVideoAdZoneId;
				
		if (!validLicenseKey) {
			if (new Random().nextInt(100) <= 1) {//0~99					
				this.appId = TEST_APP_ID;
				this.interstitialAdZoneId = TEST_INTERSTITIAL_AD_ZONE_ID;
				this.rewardedVideoAdZoneId = TEST_REWARDED_VIDEO_AD_ZONE_ID;
			}
		}

		String optionString = "";
		//version - arbitrary application version
		//store   - google or amazon
		//String optionString = "version:1.0,store:google";
/*		
		try {
			JSONObject options = args.getJSONObject(2);
			String deviceId = options.getString("deviceId");
			String customId = options.getString("customId");
			if (deviceId != null) 
                AdColony.setDeviceID( deviceId );
			if (customId != null) 
                AdColony.setCustomID( customId );
			optionString = options.getString("optionString");
		}
		catch (JSONException exception) {
			// Do nothing
		}
*/

		String[] zoneIds = new String[2];
		zoneIds[0] = this.interstitialAdZoneId;
		zoneIds[1] = this.rewardedVideoAdZoneId;

		AdColony.configure(cordova.getActivity(), optionString, this.appId, zoneIds);
		AdColony.addAdAvailabilityListener(new MyAdColonyAdAvailabilityListener());
		AdColony.addV4VCListener(new MyAdColonyV4VCListener());
	}

	private void _showInterstitialAd() {
	
		AdColonyVideoAd ad = new AdColonyVideoAd(interstitialAdZoneId);
		ad.withListener(new AdColonyAdListenerInterstitialAd());
		ad.show();
	}

	private void _showRewardedVideoAd() {
		
		AdColonyV4VCAd ad = new AdColonyV4VCAd(rewardedVideoAdZoneId);
		ad.withListener(new AdColonyAdListenerRewardedVideoAd());
		//ad.withConfirmationDialog().withResultsDialog();
		ad.show();
		
		//ad.getRewardName()
		//ad.getAvailableViews()
	}
	
	class MyAdColonyAdAvailabilityListener implements AdColonyAdAvailabilityListener {
		// Ad Availability Change Callback - update button text
		public void onAdColonyAdAvailabilityChange(boolean available, String zone_id) {
			Log.d(LOG_TAG, String.format("%s: %b", "onAdColonyAdAvailabilityChange", available));
			
			if (available) {
				if(zone_id.equals(interstitialAdZoneId)) {
					PluginResult pr = new PluginResult(PluginResult.Status.OK, "onInterstitialAdLoaded");
					pr.setKeepCallback(true);
					callbackContextKeepCallback.sendPluginResult(pr);
					//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
					//pr.setKeepCallback(true);
					//callbackContextKeepCallback.sendPluginResult(pr);			
				}
				else if(zone_id.equals(rewardedVideoAdZoneId)) {
					PluginResult pr = new PluginResult(PluginResult.Status.OK, "onRewardedVideoAdLoaded");
					pr.setKeepCallback(true);
					callbackContextKeepCallback.sendPluginResult(pr);
					//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
					//pr.setKeepCallback(true);
					//callbackContextKeepCallback.sendPluginResult(pr);
				}
			}
		}
	}

	class MyAdColonyV4VCListener implements AdColonyV4VCListener {
		// Reward Callback
		public void onAdColonyV4VCReward(AdColonyV4VCReward reward) {
			Log.d(LOG_TAG, String.format("%s: %b", "onAdColonyV4VCReward", reward.success()));
			
			if (reward.success()) {				
				//reward.name();
				//reward.amount();
								
				PluginResult pr = new PluginResult(PluginResult.Status.OK, "onRewardedVideoAdCompleted");
				pr.setKeepCallback(true);
				callbackContextKeepCallback.sendPluginResult(pr);
				//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
				//pr.setKeepCallback(true);
				//callbackContextKeepCallback.sendPluginResult(pr);				
			}
		}		
	}
	
	class AdColonyAdListenerInterstitialAd implements AdColonyAdListener {
		// Ad Started Callback, called only when an ad successfully starts playing.
		public void onAdColonyAdStarted( AdColonyAd ad ) {
			Log.d(LOG_TAG, String.format("%s", "onAdColonyAdStarted"));
			
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onInterstitialAdShown");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);			
		}
  
		//Ad Attempt Finished Callback - called at the end of any ad attempt - successful or not.
		public void onAdColonyAdAttemptFinished(AdColonyAd ad) {
			Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished"));			

			// You can ping the AdColonyAd object here for more information:
			// ad.shown() - returns true if the ad was successfully shown.
			// ad.notShown() - returns true if the ad was not shown at all (i.e. if onAdColonyAdStarted was never triggered)
			// ad.skipped() - returns true if the ad was skipped due to an interval play setting
			// ad.canceled() - returns true if the ad was cancelled (either programmatically or by the user)
			// ad.noFill() - returns true if the ad was not shown due to no ad fill.
			if (ad.shown()) {
				Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished: shown"));
				
				PluginResult pr = new PluginResult(PluginResult.Status.OK, "onInterstitialAdHidden");
				pr.setKeepCallback(true);
				callbackContextKeepCallback.sendPluginResult(pr);
				//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
				//pr.setKeepCallback(true);
				//callbackContextKeepCallback.sendPluginResult(pr);				
			}
			else if (ad.notShown()) {
				Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished: notShown"));			
			} 
			else if (ad.noFill()) {
				Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished: noFill"));			
			} 
			else if (ad.canceled()) {
				Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished: canceled"));			
			} 
			else {
				Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished: else"));			
			}
		}
	}

	class AdColonyAdListenerRewardedVideoAd implements AdColonyAdListener {
		// Ad Started Callback, called only when an ad successfully starts playing.
		public void onAdColonyAdStarted( AdColonyAd ad ) {
			Log.d(LOG_TAG, String.format("%s", "onAdColonyAdStarted"));
			
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onRewardedVideoAdShown");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);			
		}
  
		//Ad Attempt Finished Callback - called at the end of any ad attempt - successful or not.
		public void onAdColonyAdAttemptFinished(AdColonyAd ad) {
			Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished"));			

			// You can ping the AdColonyAd object here for more information:
			// ad.shown() - returns true if the ad was successfully shown.
			// ad.notShown() - returns true if the ad was not shown at all (i.e. if onAdColonyAdStarted was never triggered)
			// ad.skipped() - returns true if the ad was skipped due to an interval play setting
			// ad.canceled() - returns true if the ad was cancelled (either programmatically or by the user)
			// ad.noFill() - returns true if the ad was not shown due to no ad fill.
			if (ad.shown()) {
				Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished: shown"));
				
				PluginResult pr = new PluginResult(PluginResult.Status.OK, "onRewardedVideoAdHidden");
				pr.setKeepCallback(true);
				callbackContextKeepCallback.sendPluginResult(pr);
				//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
				//pr.setKeepCallback(true);
				//callbackContextKeepCallback.sendPluginResult(pr);				
			}
			else if (ad.notShown()) {
				Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished: notShown"));			
			} 
			else if (ad.noFill()) {
				Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished: noFill"));			
			} 
			else if (ad.canceled()) {
				Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished: canceled"));			
			} 
			else {
				Log.d(LOG_TAG, String.format("%s", "onAdColonyAdAttemptFinished: else"));			
			}
		}
	}
}
