//
//  NativeAdVC.swift
//  GoogleAdMob
//
//  Created by Akash on 07/05/24.
//

import UIKit
import GoogleMobileAds

class NativeAdVC: UIViewController {

    @IBOutlet weak var nativeAdTbl: UITableView!
    var backGroundColors = ["#FFFFFF","#0E46A3","#9AC8CD","#4793AF","#FFC470","#FFD1E3","#7BC9FF","#6C0345","#DC6B19","#D862BC","#BED7DC","#FFC94A","#481E14","#D6589F","#E72929","#FF71CD"]
    
    var adLoader: GADAdLoader!
    var nativeAd: GADNativeAd!
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup(){
        nativeAdTbl.register(UINib(nibName: "ColorCell", bundle: nil), forCellReuseIdentifier: "Colors")
//        nativeAdTbl.register(UINib(nibName: "NativeAdCell", bundle: nil), forCellReuseIdentifier: "NativeAd")
        nativeAdTbl.register(UINib(nibName: "NativeAd", bundle: nil), forCellReuseIdentifier: "NativeAd")
        GoogleAdManager.shared.delegateForNativeAd = self
        GoogleAdManager.shared.unitId = AdsId.nativeAdId
    }
}

extension NativeAdVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backGroundColors.count + (backGroundColors.count / 2)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 3 == 2{

            let cell = tableView.dequeueReusableCell(withIdentifier: "NativeAd", for: indexPath) as! NativeAd
            
            if let nativeAd = nativeAd{
                cell.setAd(nativeAd: nativeAd)
            } else {
                GoogleAdManager.shared.requestForNativeAd(rootViewController: self)
            }
            
            return cell
            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "NativeAd", for: indexPath) as! NativeAdCell
//
//            if let nativeAd = nativeAd{
//                cell.setAdInCell(nativeAd: nativeAd)
//            } else {
//                GoogleAdManager.shared.requestForNativeAd(rootViewController: self)
//            }
//            
//            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Colors", for: indexPath) as! ColorCell
            let contentIndex = indexPath.row - (indexPath.row / 3)
            let color = backGroundColors[contentIndex]
            cell.colorCode.text = color
            cell.colorView.backgroundColor = UIColor().getColorFromHex(hex: color)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 3 == 2{
            return 300
        } else {
            return 80
        }
    }
}

extension NativeAdVC: NativeAdProtocol{
    func nativeAdLoaded(ad: GADNativeAd) {
        nativeAd = ad
        nativeAdTbl.reloadData()
    }
    
    func failToLoadNativeAd() {
    }
}


extension UIColor{
    func getColorFromHex(hex: String) -> UIColor {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.currentIndex = hexString.index(after: hexString.startIndex)
        }
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
