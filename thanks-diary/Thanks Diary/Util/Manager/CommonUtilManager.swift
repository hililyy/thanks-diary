//
//  CommonUtilManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/08.
//

import UIKit

final class CommonUtilManager {
    
    static let shared = CommonUtilManager()
    private init() {}
    
    func getAppVersion() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "text_non_existent_appinfo".localized
        }
        return version
    }
    
    func dictionaryToObject <T: Decodable> (objectType: T.Type, dictionary: [[String: Any]]) -> [T]? {
        
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let objects = try? decoder.decode([T].self, from: dictionaries) else { return nil }
        return objects
        
    }
    
    func getUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
