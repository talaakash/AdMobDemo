//
//  HomeVC.swift
//  GoogleAdMob
//
//  Created by Akash on 07/05/24.
//

import UIKit

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){

    }
    
    
    @IBAction func presentInterstitialAdClicked(_ sender: UIButton){
        AdManager.shared.displayAd(type: .interstitial, viewController: self, completionHandler: { isCompleted in
            if isCompleted{
                
            } else {
                
            }
        })
    }
    
    @IBAction func presentRewardedAdClicked(_ sender: UIButton){
        AdManager.shared.displayAd(type: .rewarded, viewController: self, completionHandler: { isCompleted in
            if isCompleted{
                ToastWindow.shared.showToast(message: "You Received Gem")
            } else {
                
            }
        })
    }
    
    @IBAction func presentRewardedIntertialAd(_ sender: UIButton){
        AdManager.shared.displayAd(type: .rewardedInterstitial, viewController: self, completionHandler: { isCompleted in
            if isCompleted{
                ToastWindow.shared.showToast(message: "You Received Gem")
            } else {
                
            }
        })
    }
    
    
    @IBAction func bannerAdBtnCLicked(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(identifier: ViewControllerIdentifier.bannerAdVC) as! BannerAdVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //
    //    @IBAction func interstitialAdBtnClicked(_ sender: UIButton){
    //        let vc = storyboard?.instantiateViewController(identifier: ViewControllerIdentifier.interstitialAdVC) as! InterstitialAdVC
    //        self.navigationController?.pushViewController(vc, animated: true)
    //    }
    //
    //    @IBAction func rewardAdBtnClicked(_ sender: UIButton){
    //        let vc = storyboard?.instantiateViewController(identifier: ViewControllerIdentifier.rewardAdVC) as! RewardAdVC
    //        self.navigationController?.pushViewController(vc, animated: true)
    //    }
    //
    //    @IBAction func nativeAdBtnClicked(_ sender: UIButton){
    //        let vc = storyboard?.instantiateViewController(identifier: ViewControllerIdentifier.nativeAdVC) as! NativeAdVC
    //        self.navigationController?.pushViewController(vc, animated: true)
    //    }
    
}
