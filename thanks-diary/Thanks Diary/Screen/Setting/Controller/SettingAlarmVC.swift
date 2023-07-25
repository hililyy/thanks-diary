//
//  SettingAlarmVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import UIKit
import UserNotifications

final class SettingAlarmVC: UIViewController {
    
    // MARK: - Property
    
    var selectedDate: Date? = nil
    var selectedStringDate: String = ""
    var switchFlag: Bool = false
    var selectedTimeHour: Int = -1
    var selectedTimeMinute: Int = -1
    let userNotificationCenter = UNUserNotificationCenter.current()
    let settingAlarmView = SettingAlarmView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTarget()
        settingAlarmView.tableView.dataSource = self
        settingAlarmView.tableView.delegate = self
        self.switchFlag = false
        self.selectedTimeHour = 0
        self.selectedTimeMinute = 0
        
        self.selectedStringDate = "\(self.selectedTimeHour)시 \(self.selectedTimeMinute)분"
    }
    
    // MARK: - Function
    
    func setTarget() {
        settingAlarmView.backButtonTapHandler = {
            self.popVC()
        }
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
    
    func changeDateToString(date: Date, formatString: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = formatString
        return dateFormatter.string(from: date)
    }
}

// MARK: - UITableView

extension SettingAlarmVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = settingAlarmView.tableView.dequeueReusableCell(withIdentifier: SettingSwitchTVCell.id, for: indexPath) as! SettingSwitchTVCell
            cell.titleLabel.text = "알림 설정"
            cell.settingSwitch.isOn = switchFlag
            
            return cell

        case 1:
            let cell = settingAlarmView.tableView.dequeueReusableCell(withIdentifier: SettingLabelTVCell.id, for: indexPath) as! SettingLabelTVCell
            cell.titleLabel.text = "시간 설정"
            return cell

        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
            
        case 1:
            let vc = SettingAlarmDetailVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.selectedTime = self.selectedDate ?? Date()
            if let date = selectedDate {
                vc.selectedTime = date
            }
            self.present(vc, animated: true, completion: nil)
            
        default:
            break
        }
    }
}
