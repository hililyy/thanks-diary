//
//  SettingAlarmVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import UIKit
import UserNotifications

class SettingAlarmVC: UIViewController {

    @IBOutlet weak var alarmTableView: UITableView!
    var selectedDate: Date? = nil
    var selectedStringDate: String = ""
    var switchFlag: Bool = false
    var agreeFlag: Bool?
    var selectedTimeHour: Int = -1
    var selectedTimeMinute: Int = -1
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    private let settingModel = SettingModel.model
    private var settingAlarmView: SettingAlarmView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
        self.switchFlag = LocalDataStore.localDataStore.getPushAlarmData()
        self.agreeFlag = LocalDataStore.localDataStore.getPushAlarmAgree()
        self.selectedTimeHour = LocalDataStore.localDataStore.getPushAlarmTime()?.hour ?? -1
        self.selectedTimeMinute = LocalDataStore.localDataStore.getPushAlarmTime()?.minute ?? -1
        
        self.selectedStringDate = "\(self.selectedTimeHour)시 \(self.selectedTimeMinute)분"
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchAlarm(_ sender: Any) {
        switchFlag = !switchFlag
        if switchFlag == false {
            self.selectedTimeHour = -1
            self.selectedTimeMinute = -1
        } else {
            self.selectedTimeHour = LocalDataStore.localDataStore.getPushAlarmTime()?.hour ?? -1
            self.selectedTimeMinute = LocalDataStore.localDataStore.getPushAlarmTime()?.minute ?? -1
        }
        LocalDataStore.localDataStore.setPushAlarmData(newData: switchFlag)
        sendNotification()
    }
    
    func initalize() {
        settingAlarmView = SettingAlarmView(self)
        alarmTableView.dataSource = settingAlarmView
        alarmTableView.delegate = settingAlarmView
    }
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "💙감사일기를 작성할 시간이예요💙"
        notificationContent.body = "오늘의 일기를 작성해볼까요?💌"
        var date = DateComponents()
        date.hour = Int(self.selectedTimeHour)
        date.minute = self.selectedTimeMinute
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
