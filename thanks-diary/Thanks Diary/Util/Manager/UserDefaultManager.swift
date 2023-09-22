//
//  UserDefaultManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import Foundation

final class UserDefaultManager {
    
    private init() {}
    
    private static var _instance: UserDefaultManager?
    
    public static var instance: UserDefaultManager? {
        get {
            return _instance ?? UserDefaultManager()
        }
    }
    
    func set(_ value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func string(_ key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    func bool(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    func int(_ key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    func float(_ key: String) -> Float {
        return UserDefaults.standard.float(forKey: key)
    }
    
    func double(_ key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
    
    func array(_ key: String) -> [Any] {
        return UserDefaults.standard.array(forKey: key) ?? []
    }
    
    func dictionary(_ key: String) -> [String: Any] {
        return UserDefaults.standard.dictionary(forKey: key) ?? [:]
    }
    
    func data(_ key: String) -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }
    
    func date(_ key: String) -> Date? {
        return UserDefaults.standard.object(forKey: key) as? Date
    }
    
    func delete(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
