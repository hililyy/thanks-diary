//
//  UserDefaultManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import Foundation

final class UserDefaultManager {
    
    private init() {}
    
    private static let _instance = UserDefaultManager()
    
    static var instance: UserDefaultManager {
        return _instance
    }
    
    var isReEntryUser: Bool {
        get {
            self.bool(UserDefaultKey.IS_RE_ENTRY_USER.rawValue)
        }
        set {
            self.set(newValue, key: UserDefaultKey.IS_RE_ENTRY_USER.rawValue)
        }
    }
    
    var password: String {
        get {
            self.string(UserDefaultKey.PASSWORD.rawValue)
        }
        set {
            self.set(newValue, key: UserDefaultKey.PASSWORD.rawValue)
        }
    }
    
    var isPassword: Bool {
        get {
            self.bool(UserDefaultKey.IS_PASSWORD.rawValue)
        }
        set {
            self.set(newValue, key: UserDefaultKey.IS_PASSWORD.rawValue)
        }
    }
    
    var pushTime: Date {
        get {
            self.date(UserDefaultKey.PUSH_TIME.rawValue) ?? Date()
        }
        set {
            self.set(newValue, key: UserDefaultKey.PUSH_TIME.rawValue)
        }
    }
    
    var isPush: Bool {
        get {
            self.bool(UserDefaultKey.IS_PUSH.rawValue)
        }
        set {
            self.set(newValue, key: UserDefaultKey.IS_PUSH.rawValue)
        }
    }
    
    var themeMode: String {
        get {
            self.string(UserDefaultKey.THEME_MODE.rawValue)
        }
        set {
            self.set(newValue, key: UserDefaultKey.THEME_MODE.rawValue)
        }
    }
    
    var themeColor: Int {
        get {
            self.int(UserDefaultKey.THEME_COLOR.rawValue)
        }
        set {
            self.set(newValue, key: UserDefaultKey.THEME_COLOR.rawValue)
        }
    }
    
    var themeFont: Int {
        get {
            self.int(UserDefaultKey.THEME_FONT.rawValue)
        }
        set {
            self.set(newValue, key: UserDefaultKey.THEME_FONT.rawValue)
        }
    }

    var isPresentReviewPopup: Bool {
        get {
            self.bool(UserDefaultKey.IS_PRESENT_REVIEW_POPUP.rawValue)
        }
        set {
            self.set(newValue, key: UserDefaultKey.IS_PRESENT_REVIEW_POPUP.rawValue)
        }
    }
    
    var isBiometricsAuth: Bool {
        get {
            self.bool(UserDefaultKey.IS_BIOMETRICS_AUTH.rawValue)
        }
        set {
            self.set(newValue, key: UserDefaultKey.IS_BIOMETRICS_AUTH.rawValue)
        }
    }
}

extension UserDefaultManager {
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
