//
//  InterstitialAdVC.swift
//  GoogleAdMob
//
//  Created by Akash on 07/05/24.
//

import UIKit
import GoogleMobileAds

class InterstitialAdVC: UIViewController {

    private var interstitial: GADInterstitialAd?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
//        AdManager.shared.interstitialDelegate = self
//        AdManager.shared.loadAd(type: .interstitial)
    }
    

}
//extension InterstitialAdVC: InterstitialAd{
//    func failToLoadAd(error: String) {
//        ToastWindow.shared.showToast(message: error)
//    }
//    
//    func failToPresentAd(error: String) {
//        ToastWindow.shared.showToast(message: error)
//    }
//    
//    func willPresentAd() {
//        ToastWindow.shared.showToast(message: "Will Present Ad")
//    }
//    
//    func dismissAd() {
//        ToastWindow.shared.showToast(message: "Ad Dismissed By You")
//    }
//}
