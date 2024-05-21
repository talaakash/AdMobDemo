//
//  ViewController.swift
//  GoogleAdMob
//
//  Created by Akash on 07/05/24.
//

import UIKit
import GoogleMobileAds

class BannerAdVC: UIViewController {
    
    @IBOutlet weak var banner: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        AdManager.shared.loadBannerAd(in: &banner, viewController: self, completionHandler: { isCompleted in
            if isCompleted{
                
            } else {
                
            }
        })
    }
    
}
