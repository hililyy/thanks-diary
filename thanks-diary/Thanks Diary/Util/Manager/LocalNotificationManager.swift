//
//  LocalNotificationManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/08.
//

import Foundation
import UserNotifications

final class LocalNotificationManager {
    
    static let shared = LocalNotificationManager()
    private init() {}
    
    ///Push Notification에 대한 인증 설정 함수입니다.
    func setAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
    }
    
    /// 대기중인 Push Notification을 출력합니다.
    func printPendingNotification() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                print("Identifier: \(request.identifier)")
                print("Title: \(request.content.title)")
                print("Body: \(request.content.body)")
                print("Trigger: \(String(describing: request.trigger))")
                print("---")
            }
        }
    }
    
    /// 대기중인 Push Notification을 취소합니다.
    /// - Parameter identifiers: 삭제하고자하는 알림 식별자 리스트입니다.
    func removePendingNotification(identifiers: [String]){
        UNUserNotificationCenter
            .current()
            .removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    /// 이미 전달된 Push Notification을 알림센터에서 삭제합니다.
    /// - Parameter identifiers: 삭제하고자하는 알림 식별자 리스트입니다.
    func removeDeliveredNotification(identifiers: [String]){
        UNUserNotificationCenter
            .current()
            .removeDeliveredNotifications(withIdentifiers: identifiers)
    }
    
    func requestSendNotification(title: String = "", contents: String = "", time: Date) {
        
        let content = UNMutableNotificationContent()
        content.title = "text_push_title".localized
        content.body = "text_push_contents".localized
            
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        
        let timeStr = dateFormatter.string(from: time)
        let hourString = timeStr.prefix(2)
        let minuteString = timeStr.suffix(2)
        guard let hour = Int(hourString), let minute = Int(minuteString) else { return }
            
        dateComponents.hour = hour
        dateComponents.minute = minute
            
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
        let request = UNNotificationRequest(identifier: "LOCAL_PUSH",
                                            content: content,
                                            trigger: trigger)
            
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
