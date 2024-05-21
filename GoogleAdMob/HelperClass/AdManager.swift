//
//  AdManager.swift
//  GoogleAdMob
//
//  Created by Akash on 09/05/24.
//

import Foundation
import GoogleMobileAds


enum AdType{
    case interstitial
    case rewarded
    case rewardedInterstitial
    case appOpen
}

typealias CompletionBlock = ((Bool) -> Void)


class AdManager : NSObject {
    static let shared = AdManager()
    private var request = GADRequest()
    private var interstitial: GADInterstitialAd? = nil
    private var rewarded: GADRewardedAd? = nil
    private var rewardedInterstitial: GADRewardedInterstitialAd? = nil
    private var appOpen: GADAppOpenAd? = nil
    private var isFullAdWatched = false
    
    // Loading Fail Counter
    private let retryCount = 3
    private let retryInterval = 2.0
    
    private var interstitialLoadFailureCount = 0
    private var rewardedLoadFailureCount = 0
    private var rewardedInterstitialLoadFailureCount = 0
    private var appOpenLoadFailureCount = 0
    
    // Completion Handler
    private var bannerAdCallBack: CompletionBlock? = nil
    private var adCallBack: CompletionBlock? = nil // Handler For give response to full screen ad completed and reward
    
    private override init(){
        super.init()
    }
    
    // MARK: Load Ads
    private func loadInterstitialAd(){
        GADInterstitialAd.load(withAdUnitID: AdsId.interstitialAdId, request: request, completionHandler: { response, error in
            if let response = response{
                self.interstitial = response
                self.interstitialLoadFailureCount = 0
            } else if let _ = error{
                if self.interstitialLoadFailureCount < self.retryCount{
                    self.interstitialLoadFailureCount += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.retryInterval, execute: {
                        self.loadInterstitialAd()
                    })
                }
            }
        })
    }
    
    private func loadRewardedInterstitialAd(){
        GADRewardedInterstitialAd.load(withAdUnitID: AdsId.rewardedInterstitialAdId, request: request, completionHandler: { response, error in
            if let response = response{
                self.rewardedInterstitial = response
                self.rewardedInterstitialLoadFailureCount = 0
            } else if let _ = error{
                if self.rewardedInterstitialLoadFailureCount < self.retryCount{
                    self.rewardedInterstitialLoadFailureCount += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.retryInterval, execute: {
                        self.loadRewardedInterstitialAd()
                    })
                }
            }
        })
    }
    
    private func loadAppOpenAd(){
        GADAppOpenAd.load(withAdUnitID: AdsId.appOpenAdId, request: request, completionHandler: { response, error in
            if let response = response{
                self.appOpen = response
                self.appOpenLoadFailureCount = 0
            } else if let _ = error{
                if self.appOpenLoadFailureCount < self.retryCount{
                    self.appOpenLoadFailureCount += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.retryInterval, execute: {
                        self.loadAppOpenAd()
                    })
                }
            }
        })
    }
    
    private func loadRewardedAd(){
        GADRewardedAd.load(withAdUnitID: AdsId.rewardedAdId, request: request, completionHandler: { response, error in
            if let response = response{
                self.rewarded = response
                self.rewardedLoadFailureCount = 0
            } else if let _ = error{
                if self.rewardedLoadFailureCount < self.retryCount{
                    self.rewardedLoadFailureCount += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.retryInterval, execute: {
                        self.loadRewardedAd()
                    })
                }
            }
        })
    }
    
    func loadAllAds(){
        // Load App Open Ad
        loadAppOpenAd()
        
        // Load Interstitial Ad
        loadInterstitialAd()
        
        // Load Rewarded Ad
        loadRewardedAd()
        
        // Load Rewarded Interstitial Ad
        loadRewardedInterstitialAd()
    }
    
    func loadBannerAd(in banner: inout GADBannerView, viewController: UIViewController, completionHandler: @escaping (Bool) -> Void){
        bannerAdCallBack = completionHandler
        banner.adUnitID = AdsId.bannerAdId
        banner.delegate = self
        banner.rootViewController = viewController
        banner.load(request)
    }
    
    // MARK: Show Preloaded Ads if not loaded then load and return nil
    func displayAd(type: AdType, viewController: UIViewController, completionHandler: @escaping CompletionBlock){
        adCallBack = completionHandler
        switch type{
        case .interstitial:
            if let interstitialAd = interstitial{
                interstitialAd.fullScreenContentDelegate = self
                interstitialAd.present(fromRootViewController: viewController)
            } else {
                loadInterstitialAd()
                completionHandler(false)
            }
        case .rewarded:
            if let rewardedAd = rewarded{
                rewardedAd.fullScreenContentDelegate = self
                rewardedAd.present(fromRootViewController: viewController, userDidEarnRewardHandler: {
                    self.isFullAdWatched = true
                })
            } else {
                loadRewardedAd()
                completionHandler(false)
            }
        case .rewardedInterstitial:
            if let rewardedInterstitialAd = rewardedInterstitial{
                rewardedInterstitialAd.fullScreenContentDelegate = self
                rewardedInterstitialAd.present(fromRootViewController: viewController, userDidEarnRewardHandler: {
                    self.isFullAdWatched = true
                })
            } else {
                loadRewardedInterstitialAd()
                completionHandler(false)
            }
        case .appOpen:
            if let appOpenAd = appOpen{
                appOpenAd.fullScreenContentDelegate = self
                appOpenAd.present(fromRootViewController: viewController)
            } else {
                loadAppOpenAd()
                completionHandler(false)
            }
        }
    }
}

extension AdManager: GADBannerViewDelegate{
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerAdCallBack?(true)
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        bannerAdCallBack?(false)
    }
}

extension AdManager: GADFullScreenContentDelegate{
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        if let _ = ad as? GADRewardedAd{
            adCallBack?(isFullAdWatched)
            self.rewarded = nil
            loadRewardedAd()
        } else if let _ = ad as? GADRewardedInterstitialAd {
            adCallBack?(isFullAdWatched)
            self.rewardedInterstitial = nil
            loadRewardedInterstitialAd()
        } else if let _ = ad as? GADAppOpenAd {
            adCallBack?(true)
            self.appOpen = nil
            loadAppOpenAd()
        } else {
            adCallBack?(true)
            self.interstitial = nil
            loadInterstitialAd()
        }
        isFullAdWatched = false
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {

    }
}
