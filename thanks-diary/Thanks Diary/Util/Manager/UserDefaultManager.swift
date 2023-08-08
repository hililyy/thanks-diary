//
//  UserDefaultManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import Foundation

class UserDefaultManager {
    
    class func set(_ value: Any, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    class func string(forKey: String) -> String {
        return UserDefaults.standard.string(forKey: forKey) ?? ""
    }
    
    class func bool(forKey: String) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey)
    }
    
    class func int(forKey: String) -> Int {
        return UserDefaults.standard.integer(forKey: forKey)
    }
    
    class func float(forKey: String) -> Float {
        return UserDefaults.standard.float(forKey: forKey)
    }
    
    class func double(forKey: String) -> Double {
        return UserDefaults.standard.double(forKey: forKey)
    }
    
    class func array(forKey: String) -> [Any] {
        return UserDefaults.standard.array(forKey: forKey) ?? []
    }
    
    class func dictionary(forKey: String) -> [String : Any] {
        return UserDefaults.standard.dictionary(forKey: forKey) ?? [:]
    }
    
    class func data(forKey: String) -> Data? {
        return UserDefaults.standard.data(forKey: forKey)
    }
    
    class func date(forKey: String) -> Date? {
        return UserDefaults.standard.object(forKey: forKey) as? Date
    }
    
    class func delete(forKey: String) {
        UserDefaults.standard.removeObject(forKey: forKey)
    }
}
