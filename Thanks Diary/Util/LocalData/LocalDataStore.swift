//
//  LocalDataStore.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import Foundation

class LocalDataStore {
    static let localDataStore = LocalDataStore()
    
    func getNewUserData() -> Bool {
        let getData = UserDefaults.standard.bool(forKey: LocalDataKeySet.IS_NEW_USER.rawValue)
        return getData
    }
    
    func setNewUserData(newData: Bool) {
        UserDefaults.standard.setValue(newData, forKey: LocalDataKeySet.IS_NEW_USER.rawValue)
    }
    
    func getPushAlarmData() -> Bool {
        let getData = UserDefaults.standard.bool(forKey: LocalDataKeySet.IS_PUSH_ALARM.rawValue)
        return getData
    }
    
    func setPushAlarmData(newData: Bool) {
        UserDefaults.standard.setValue(newData, forKey: LocalDataKeySet.IS_PUSH_ALARM.rawValue)
    }
    
    func getPasswordData() -> Bool {
        let getData = UserDefaults.standard.bool(forKey: LocalDataKeySet.IS_PASSWORD.rawValue)
        return getData
    }
    
    func setPasswordData(newData: Bool) {
        UserDefaults.standard.setValue(newData, forKey: LocalDataKeySet.IS_PASSWORD.rawValue)
    }
}
