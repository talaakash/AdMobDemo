//
//  Constfile.swift
//  GoogleAdMob
//
//  Created by Akash on 07/05/24.
//

import Foundation

class AdsId{
    static let bannerAdId = isTestMode ? "ca-app-pub-3940256099942544/2435281174" : "ca-app-pub-3241906962390788/6665310570"
    static let interstitialAdId = isTestMode ? "ca-app-pub-3940256099942544/4411468910" : "ca-app-pub-3241906962390788/5935548800"
    static let rewardedAdId = isTestMode ? "ca-app-pub-3940256099942544/1712485313" : "ca-app-pub-3241906962390788/9691547711"
    static let nativeAdId = isTestMode ? "ca-app-pub-3940256099942544/3986624511" : "ca-app-pub-3241906962390788/3277348451"
    static let rewardedInterstitialAdId = isTestMode ? "ca-app-pub-3940256099942544/6978759866" : "ca-app-pub-3241906962390788/4414421873"
    static let appOpenAdId = isTestMode ? "ca-app-pub-3940256099942544/5575463023" : "ca-app-pub-3241906962390788/4270951647"
}

class ViewControllerIdentifier{
    static let bannerAdVC = "BannerAdVC"
    static let interstitialAdVC = "InterstitialAdVC"
    static let rewardAdVC = "RewardAdVC"
    static let nativeAdVC = "NativeAdVC"
}
