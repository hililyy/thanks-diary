//
//  AuthManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import UserNotifications
import LocalAuthentication

final class AuthManager {
    
    private init() {}
    
    private static let _instance = AuthManager()
    
    static var instance: AuthManager {
        return _instance
    }
    
    // MARK: - 알람 권한
    
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
    
    // MARK: - 생체인증 권한
    
    private var context = LAContext()
    
    func execute(completion: @escaping (Bool) -> Void) {
        var error: NSError?
        let canAuth = context.canEvaluatePolicy(.deviceOwnerAuthentication,
                                                error: &error)
        if canAuth {
            let reason = "Log in to your account"
            context.evaluatePolicy(.deviceOwnerAuthentication,
                                   localizedReason: reason) { result, _ in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}
