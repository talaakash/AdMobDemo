//
//  GoogleAdManager.swift
//  GoogleAdMob
//
//  Created by Akash on 07/05/24.
//

import Foundation
import GoogleMobileAds

public protocol NativeAdProtocol{
    func nativeAdLoaded(ad: GADNativeAd)
    func failToLoadNativeAd()
}

class GoogleAdManager: NSObject{
    static let shared = GoogleAdManager()
    var delegateForNativeAd: NativeAdProtocol?
    var adLoaderForNativeAd: GADAdLoader!

    var unitId: String!
    
    func requestForNativeAd(rootViewController: UIViewController){
        adLoaderForNativeAd = GADAdLoader(adUnitID: AdsId.nativeAdId, rootViewController: rootViewController, adTypes: [.native], options: nil)
        adLoaderForNativeAd.delegate = self
        adLoaderForNativeAd.load(GADRequest())
    }
    
}

extension GoogleAdManager: GADNativeAdLoaderDelegate{
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        if delegateForNativeAd != nil{
            delegateForNativeAd?.nativeAdLoaded(ad: nativeAd)
        }
    }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        if delegateForNativeAd != nil{
            delegateForNativeAd?.failToLoadNativeAd()
        }
    }
}
