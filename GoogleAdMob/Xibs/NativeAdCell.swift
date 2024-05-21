//
//  NativeAdCell.swift
//  GoogleAdMob
//
//  Created by Akash on 09/05/24.
//

import UIKit
import GoogleMobileAds

class NativeAdCell: UITableViewCell {

    @IBOutlet weak var nativeAdView: GADNativeAdView!
    @IBOutlet weak var mediaView: GADMediaView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var adBadge: UILabel!
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var advertise: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var starRating: UILabel!
    @IBOutlet weak var callToAction: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAdInCell(nativeAd: GADNativeAd){
        mediaView.mediaContent = nativeAd.mediaContent
        body.text = nativeAd.body
        advertise.text = nativeAd.advertiser
        headline.text = nativeAd.headline
        iconView.image = nativeAd.icon?.image
        starRating.text = String(describing: nativeAd.starRating ?? 0)
        callToAction.setTitle(nativeAd.callToAction, for: .normal)
        callToAction.isUserInteractionEnabled = false
        nativeAdView.nativeAd = nativeAd
        nativeAdView.callToActionView = callToAction
        nativeAdView.nativeAd?.delegate = self
    }
    
}

extension NativeAdCell: GADNativeAdDelegate{
    func nativeAdDidRecordClick(_ nativeAd: GADNativeAd) {
        print("Clicked")
    }
    
    func nativeAdDidRecordImpression(_ nativeAd: GADNativeAd) {
        print("Impression")
    }
}
