//
//  SettingModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/23.
//

import Foundation

class SettingModel {
    static var model = SettingModel()
    var loginType: LoginType = LoginType(rawValue: LocalDataStore.localDataStore.getLoginType())!
    var alarmFlag: Bool = LocalDataStore.localDataStore.getPasswordData()
    
    func touchSwitchAlarm(completion: () -> ()) {
        alarmFlag = !alarmFlag
        LocalDataStore.localDataStore.setPasswordData(newData: alarmFlag)
        if LocalDataStore.localDataStore.getPasswordData() == true {
            completion()
        }
    }
    
}
