//
//  AuthManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import UserNotifications

final class AuthManager {
    
    private init() {}
    
    private static let _instance = AuthManager()
    
    static var instance: AuthManager {
        return _instance
    }
    
    // 콜백 안쓸수 있으면 안쓰는게 좋음
    func requestNotiAuth(completion: @escaping (Bool) -> Void, errorHandler: @escaping () -> Void) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { success, error in
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
