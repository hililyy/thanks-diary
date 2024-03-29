//
//  CommonUtilManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/08.
//

import UIKit
import StoreKit
import RxSwift
import RxCocoa

final class CommonUtilManager {
    
    private init() {}
    
    private static let _instance = CommonUtilManager()
    
    static var instance: CommonUtilManager {
        return _instance
    }

    var themeSubject = PublishSubject<Int>()
    var tableViewOffset: CGPoint = .zero
    
    var uuid: String {
        guard let uuid = UIDevice.current.identifierForVendor else { return "" }
        return uuid.uuidString
    }
    
    var appVersion: String {
        guard let version = Bundle.main.infoDictionary?[Constant.INFO_APP_VERSION] as? String else {
            return L10n.nonExistentAppinfo
        }
        return version
    }
    
    func dictionaryToObject <T: Decodable> (objectType: T.Type,
                                            dictionary: [[String: Any]]) -> [T]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary),
              let objects = try? decoder.decode([T].self, from: dictionaries) else { return nil }
        
        return objects
    }
    
    func presentAppReviewPopup() {
        let bundleVersionKey = kCFBundleVersionKey as String // "CFBundleVersion"
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: bundleVersionKey) as? String // build version
        let lastVersion = UserDefaults.standard.string(forKey: "lastVersion")
        
        guard lastVersion == nil || lastVersion != currentVersion else { return }
        guard let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
        
        SKStoreReviewController.requestReview(in: scene)
    }
    
    func moveAppStoreReview() {
        guard let appstoreUrl = URL(string: "https://apps.apple.com/app/id6443505485") else { return }
        
        var urlComp = URLComponents(url: appstoreUrl, resolvingAgainstBaseURL: false)
        urlComp?.queryItems = [URLQueryItem(name: "action", value: "write-review")]
        
        guard let reviewUrl = urlComp?.url else { return }
        UIApplication.shared.open(reviewUrl, options: [:], completionHandler: nil)
    }
}
