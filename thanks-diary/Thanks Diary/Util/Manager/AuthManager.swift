//
//  AuthManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import UserNotifications

final class AuthManager {
    
    static let shared = AuthManager()
    private init() {}
    
    func requestNotiAuth(completion: @escaping (Bool) -> Void, errorHandler: @escaping () -> Void) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { success, error in
            print("success: \(success)")
            completion(success)
            if error != nil {
                errorHandler()
            }
        }
    }
    
    func getNotiStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { setting in
            completion(setting.authorizationStatus)
        }
    }
}
