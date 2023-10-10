//
//  LocalNotificationManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/08.
//

import Foundation
import UserNotifications

final class LocalNotificationManager {
    
    private init() {}
    
    private static var _instance: LocalNotificationManager?
    
    public static var instance: LocalNotificationManager? {
        return _instance ?? LocalNotificationManager()
    }
    
    func printRegistedNotification() {
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
    
    func cancelRegistedNotification(identifiers: [String] = []) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [Constant.PUSH_IDENTIFIER])
    }
    
    func removeDeliveredNotification(identifiers: [String] = []) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [Constant.PUSH_IDENTIFIER])
    }
    
    func registNotification(title: String = "", contents: String = "", time: Date) {
        
        let content = UNMutableNotificationContent()
        content.title = L10n.pushTitle
        content.body = L10n.pushContents
            
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.HHMM
        
        let timeStr = dateFormatter.string(from: time)
        let hourString = timeStr.prefix(2)
        let minuteString = timeStr.suffix(2)
        guard let hour = Int(hourString), let minute = Int(minuteString) else { return }
            
        dateComponents.hour = hour
        dateComponents.minute = minute
            
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
        let request = UNNotificationRequest(identifier: Constant.PUSH_IDENTIFIER,
                                            content: content,
                                            trigger: trigger)
            
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
