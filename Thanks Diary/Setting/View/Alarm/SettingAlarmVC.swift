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
    var agreeFlag: Bool = false
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmTableView.dataSource = self
        alarmTableView.delegate = self
        self.switchFlag = LocalDataStore.localDataStore.getPushAlarmData()
        self.agreeFlag = LocalDataStore.localDataStore.getPushAlarmAgree()
       // userNotificationCenter.delegate = self
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchAlarm(_ sender: Any) {
        switchFlag = !switchFlag
        LocalDataStore.localDataStore.setPushAlarmData(newData: switchFlag)
       // sendNotification(seconds: 10)
    }
    
    func sendNotification(seconds: Double) {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "알림 테스트"
        notificationContent.body = "이것은 알림을 테스트 하는 것이다"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
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
        
        dateFormatter.dateFormat = "a hh시 mm분"
        return dateFormatter.string(from: date)
    }
}

extension SettingAlarmVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = self.alarmTableView.dequeueReusableCell(withIdentifier: "AlarmSettingCell", for: indexPath) as! AlarmSettingCell
            if agreeFlag == false {
                cell.alarmSwitchBtn.isEnabled = false
            } else {
                cell.alarmSwitchBtn.isOn = switchFlag
            }
            return cell
        case 1:
            let cell = self.alarmTableView.dequeueReusableCell(withIdentifier: "AlarmTimeCell", for: indexPath) as! AlarmTimeCell
            cell.selectionStyle = .none
            if agreeFlag == false {
                cell.selectedTimeLabel.text = "설정에서 알림을 허용해 주세요."
            } else {
                cell.selectedTimeLabel.text = self.selectedStringDate
            }
            return cell
        default:
            return UITableViewCell.init()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case 1:
            if agreeFlag == true {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingAlarmDetailVC") as? SettingAlarmDetailVC {
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overCurrentContext
                    vc.delegate = self
                    if let date = selectedDate {
                        vc.selectedTime = date
                    }
                    self.present(vc, animated: true, completion: nil)
                }
            } else {
                break
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension SettingAlarmVC: SendDataDelegate {
    func sendData(_ date: Date) {
        self.selectedDate = date
        selectedStringDate = changeDateToString(date: self.selectedDate ?? Date(), formatString: "a hh시 mm분")
        self.alarmTableView.reloadData()
    }
    
}
