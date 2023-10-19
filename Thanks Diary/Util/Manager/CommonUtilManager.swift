//
//  CommonUtilManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/08.
//

import UIKit

final class CommonUtilManager {
    
    private init() {}
    
    private static var _instance: CommonUtilManager?
    
    static var instance: CommonUtilManager? {
        if _instance == nil {
            _instance = CommonUtilManager()
        }
        return _instance
    }
    
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
    
    func dictionaryToObject <T: Decodable> (
        objectType: T.Type,
        dictionary: [[String: Any]]) -> [T]? {
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let objects = try? decoder.decode([T].self, from: dictionaries) else { return nil }
        return objects
    }
}
