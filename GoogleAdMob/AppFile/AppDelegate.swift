//
//  AppDelegate.swift
//  GoogleAdMob
//
//  Created by Akash on 07/05/24.
//

import UIKit
import GoogleMobileAds
import UserMessagingPlatform
import AppTrackingTransparency
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window:UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customisation after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        self.checkUserConsent()
//        if UserDefaults.standard.object(forKey: "isConsentAvailable") as? Bool ?? false{
//            self.loadAds()
//        } else {
//            
//        }
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        guard let viewController = window?.rootViewController else { return }
        AdManager.shared.displayAd(type: .appOpen, viewController: viewController, completionHandler: {_ in})
    }
    
    private func checkUserConsent(){
        let parameters = UMPRequestParameters()
        let debugSettings = UMPDebugSettings()
        debugSettings.geography = .EEA
        parameters.debugSettings = debugSettings

        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: isTestMode ? parameters : nil, completionHandler: { requestConsentError in
            if let error = requestConsentError?.localizedDescription {
                print(error)
            } else {
                print(UMPConsentInformation.sharedInstance.canRequestAds)
                
                let consentStatus = UMPConsentInformation.sharedInstance.consentStatus
                if consentStatus == .obtained || consentStatus == .notRequired{
                    if UMPConsentInformation.sharedInstance.canRequestAds {
                        UserDefaults.standard.setValue(true, forKey: "isConsentAvailable")
                        self.checkATTAuthorization()
                    }
                } else {
                    self.showConsentForm()
                }
            }
        })
    }
    
    private func showConsentForm(){
        guard let viewController = window?.rootViewController else { return }
        UMPConsentForm.loadAndPresentIfRequired(from: viewController, completionHandler: { loadAndPresentError in
            if let consentError = loadAndPresentError {
                print("Error: \(consentError.localizedDescription)")
            } else {
                self.checkATTAuthorization()
            }
        })
    }
    
    private func checkATTAuthorization(){ // Request User for Authorisation for App Tracking Transparency
        if #available(iOS 14, *){
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("enable tracking")
                case .denied:
                    print("disable tracking")
                default:
                    print("disable tracking")
                }
                self.loadAds()
            }
        }
    }
    
    func loadAds(){
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        AdManager.shared.loadAllAds()
    }

}

