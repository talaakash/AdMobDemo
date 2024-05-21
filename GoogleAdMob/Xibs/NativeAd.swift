//
//  NativeAd.swift
//  GoogleAdMob
//
//  Created by Akash on 09/05/24.
//

import UIKit
import GoogleMobileAds

class NativeAd: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAd(nativeAd: GADNativeAd){
        let nibObj = Bundle.main.loadNibNamed("NativeAddLargeSize", owner: nil, options: nil)
        guard let nativeAdView = nibObj?.first as? GADNativeAdView else { return }
        
        self.contentView.addSubview(nativeAdView)
        nativeAdView.frame = contentView.bounds
        
        (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
        nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent
        
        nativeAdView.mediaView?.contentMode = .scaleToFill
        
        (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
        nativeAdView.bodyView?.isHidden = nativeAd.body == nil
        
        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil
        
        (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        nativeAdView.iconView?.isHidden = nativeAd.icon == nil
        
        (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
        nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil
        
        nativeAdView.callToActionView?.isUserInteractionEnabled = false
        
        nativeAdView.nativeAd = nativeAd
    }
    
}
