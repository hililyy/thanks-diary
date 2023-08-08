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
    
    // 대기중인 Push Notification 출력
    func printPendingNotification() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                print("Identifier: \(request.identifier)")
                print("Title: \(request.content.title)")
                print("Body: \(request.content.body)")
                print("Trigger: \(String(describing: request.trigger))")
                print("-------------------------")
            }
        }
    }
    
    // 대기중인 Push Notification 취소
    func removePendingNotification(identifiers: [String] = []){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["LOCAL_PUSH"])
    }
    
    // 이미 전달된 Push Notification을 알림센터에서 삭제 (이미 도착한 푸시 메시지 삭제)
    func removeDeliveredNotification(identifiers: [String] = []){
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["LOCAL_PUSH"])
    }
    
    // 푸시 메시지 등록
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
