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
    
    func getPasswordNumber() -> String {
        let getData = UserDefaults.standard.string(forKey: LocalDataKeySet.PASSWORD_NUMBER.rawValue)
        return getData ?? ""
    }
    
    func setPasswordNumber(newData: String) {
        UserDefaults.standard.setValue(newData, forKey: LocalDataKeySet.PASSWORD_NUMBER.rawValue)
    }
    
    func getTodayDetailData() -> Bool {
        let getData = UserDefaults.standard.bool(forKey: LocalDataKeySet.TODAY_DETAIL_DIARY.rawValue)
        return getData
    }
    
    func setTodayDetailData(newData: Bool) {
        UserDefaults.standard.setValue(newData, forKey: LocalDataKeySet.TODAY_DETAIL_DIARY.rawValue)
    }
    
    func getPushAlarmAgree() -> Bool {
        let getData = UserDefaults.standard.bool(forKey: LocalDataKeySet.IS_PUSH_ALARM_AGREE.rawValue)
        return getData
    }
    
    func setPushAlarmAgree(newData: Bool) {
        UserDefaults.standard.setValue(newData, forKey: LocalDataKeySet.IS_PUSH_ALARM_AGREE.rawValue)
    }
    
    func getPushAlarmTime() -> AlarmTimeEntity {
        guard let getData = UserDefaults.standard.value(forKey: LocalDataKeySet.ALARM_TIME.rawValue) as? Data else { return AlarmTimeEntity(hour: -1, minute: -1) }
        let diaryData = try? PropertyListDecoder().decode (
            AlarmTimeEntity.self, from: getData
            )
        return diaryData ?? AlarmTimeEntity(hour: -1, minute: -1)
    }
    
    func setPushAlarmTime(newData: AlarmTimeEntity) {
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newData), forKey: LocalDataKeySet.ALARM_TIME.rawValue)
    }
    
}
