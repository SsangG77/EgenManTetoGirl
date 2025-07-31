//
//  AdManager.swift
//  EgenManTetoGirl
//
//  Created by 차상진 on 7/31/25.
//

import Foundation
import GoogleMobileAds

class AdManager: NSObject, FullScreenContentDelegate {
    static let shared = AdManager()
    private override init() {}

    private var interstitial: InterstitialAd?
    private var completion: (() -> Void)?
    
    enum AdType {
        case test, real
    }
    
    func getAdId(_ t: AdType) -> String {
        if t == .real {
            return ProcessInfo.processInfo.environment["ADMOB_ID"] ?? "ca-app-pub-3940256099942544/4411468910"
        } else {
            return "ca-app-pub-3940256099942544/4411468910"
        }
        
    }

    func loadInterstitialAd() {
        let request = Request()
#warning("Ad id")
        // let id = getAdId(.test)
        
        #if DEBUG
        let id = "ca-app-pub-3940256099942544/4411468910"
        #else
        let id = "ca-app-pub-3545555975398754/1374892852"
        #endif
        
        InterstitialAd.load(with: id, request: request) { [weak self] ad, error in
            if let ad = ad {
                self?.interstitial = ad
                ad.fullScreenContentDelegate = self
            } else {
                self?.interstitial = nil
            }
        }
    }

    func showInterstitialAd(from viewController: UIViewController, completion: @escaping () -> Void) {
        if let interstitial = interstitial {
            self.completion = completion
            interstitial.present(from: viewController)
        } else {
            completion()
        }
    }

    // 광고가 닫혔을 때 호출
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        completion?()
        completion = nil
        loadInterstitialAd() // 다음을 위해 미리 로드
    }
}
