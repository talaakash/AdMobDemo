//
//  RewardAdVC.swift
//  GoogleAdMob
//
//  Created by Akash on 07/05/24.
//

import UIKit
import GoogleMobileAds

class RewardAdVC: UIViewController {

    private var rewardedAd: GADRewardedAd?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        GADRewardedAd.load(withAdUnitID: AdsId.rewardedAdId, request: GADRequest(), completionHandler: { response, error in
            if let response = response{
                self.rewardedAd = response
                self.rewardedAd?.fullScreenContentDelegate = self
                self.rewardedAd?.present(fromRootViewController: nil, userDidEarnRewardHandler: {
                    let reward = self.rewardedAd?.adReward.amount
                    ToastWindow.shared.showToast(message: "You Received \(reward ?? 0) Gem")
                })
            }
        })
    }

}

extension RewardAdVC: GADFullScreenContentDelegate{
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }
    
    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.navigationController?.popViewController(animated: true)
    }
}
