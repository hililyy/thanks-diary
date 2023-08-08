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
    
    func requestNotiAuth() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) { success, error in
                print("success: \(success)")
                if let error = error {
                    print("Error: \(error)")
                    // TODO: 오류 팝업 노출
                }
            }
    }
    
    func getNotiStatus(completion: @escaping (UNAuthorizationStatus) -> ()) {
        UNUserNotificationCenter.current().getNotificationSettings { setting in
            completion(setting.authorizationStatus)
        }
    }
}
