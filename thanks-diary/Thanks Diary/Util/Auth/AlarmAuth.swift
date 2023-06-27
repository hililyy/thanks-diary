//
//  AlarmAuth.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import UserNotifications

final class AlarmAuth {
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            print("success: \(success)")
//            LocalDataStore.localDataStore.setPushAlarmAgree(newData: success)
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
}
