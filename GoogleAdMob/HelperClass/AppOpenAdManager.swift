//
//  AppOpenAdManager.swift
//  GoogleAdMob
//
//  Created by Akash on 07/05/24.
//

import Foundation
import GoogleMobileAds

class AppOpenAdManager: NSObject, GADFullScreenContentDelegate {
  // ...

  private func loadAd() async {
    // Do not load ad if there is an unused ad or one is already loading.
    if isLoadingAd || isAdAvailable() {
      return
    }
    isLoadingAd = true

    do {
      appOpenAd = try await GADAppOpenAd.load(
        withAdUnitID: "ca-app-pub-3940256099942544/5575463023", request: GADRequest())
      appOpenAd?.fullScreenContentDelegate = self
    } catch {
      print("App open ad failed to load with error: \(error.localizedDescription)")
    }
    isLoadingAd = false
  }

  // ...

  // MARK: - GADFullScreenContentDelegate methods

  func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    print("App open ad will be presented.")
  }

  func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    appOpenAd = nil
    isShowingAd = false
    // Reload an ad.
    Task {
      await loadAd()
    }
  }

  func ad(
    _ ad: GADFullScreenPresentingAd,
    didFailToPresentFullScreenContentWithError error: Error
  ) {
    appOpenAd = nil
    isShowingAd = false
    // Reload an ad.
    Task {
      await loadAd()
    }
  }
}
