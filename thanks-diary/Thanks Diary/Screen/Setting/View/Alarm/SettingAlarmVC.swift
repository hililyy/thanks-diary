////
////  SettingAlarmVC.swift
////  Thanks Diary
////
////  Created by 강조은 on 2022/09/01.
////
//
//import UIKit
//import UserNotifications
//
//class SettingAlarmVC: UIViewController {
//
//    @IBOutlet weak var alarmTableView: UITableView!
//    var selectedDate: Date? = nil
//    var selectedStringDate: String = ""
//    var switchFlag: Bool = false
//    var agreeFlag: Bool = false
//    var selectedTimeHour: Int = -1
//    var selectedTimeMinute: Int = -1
//    let userNotificationCenter = UNUserNotificationCenter.current()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        alarmTableView.dataSource = self
//        alarmTableView.delegate = self
//        self.switchFlag = LocalDataStore.localDataStore.getPushAlarmData()
////        self.agreeFlag = LocalDataStore.localDataStore.getPushAlarmAgree()
////        self.selectedTimeHour = LocalDataStore.localDataStore.getPushAlarmTime().hour ?? -1
////        self.selectedTimeMinute = LocalDataStore.localDataStore.getPushAlarmTime().minute ?? -1
//        
//        self.selectedStringDate = "\(self.selectedTimeHour)시 \(self.selectedTimeMinute)분"
//    }
//    
//    @IBAction func goBack(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    @IBAction func switchAlarm(_ sender: Any) {
//        switchFlag = !switchFlag
//        if switchFlag == false {
//            self.selectedTimeHour = -1
//            self.selectedTimeMinute = -1
//        } else {
////            self.selectedTimeHour = LocalDataStore.localDataStore.getPushAlarmTime().hour ?? -1
////            self.selectedTimeMinute = LocalDataStore.localDataStore.getPushAlarmTime().minute ?? -1
//        }
//        LocalDataStore.localDataStore.setPushAlarmData(newData: switchFlag)
//        sendNotification()
//    }
//    
//    func sendNotification() {
//        let notificationContent = UNMutableNotificationContent()
//
//        notificationContent.title = "💙감사일기를 작성할 시간이예요💙"
//        notificationContent.body = "오늘의 일기를 작성해볼까요?💌"
//        var date = DateComponents()
//        date.hour = Int(self.selectedTimeHour)
//        date.minute = self.selectedTimeMinute
//        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
//        let request = UNNotificationRequest(identifier: "testNotification",
//                                            content: notificationContent,
//                                            trigger: trigger)
//
//        userNotificationCenter.add(request) { error in
//            if let error = error {
//                print("Notification Error: ", error)
//            }
//        }
//    }
//    
//    func changeDateToString(date: Date, formatString: String) -> String {
//        let dateFormatter = DateFormatter()
//        
//        dateFormatter.dateFormat = formatString
//        return dateFormatter.string(from: date)
//    }
//}
//
//extension SettingAlarmVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.row {
//        case 0:
//            let cell = self.alarmTableView.dequeueReusableCell(withIdentifier: "AlarmSettingCell", for: indexPath) as! AlarmSettingCell
//            if agreeFlag == false {
//                cell.alarmSwitchBtn.isEnabled = false
//            } else {
//                cell.alarmSwitchBtn.isOn = switchFlag
//            }
//            return cell
//            
//        case 1:
//            let cell = self.alarmTableView.dequeueReusableCell(withIdentifier: "AlarmTimeCell", for: indexPath) as! AlarmTimeCell
//            cell.selectionStyle = .none
//            if agreeFlag == false {
//                cell.selectedTimeLabel.text = "설정에서 알림을 허용해 주세요."
//            } else {
//                if LocalDataStore.localDataStore.getPushAlarmTime().hour == -1 {
//                    cell.selectedTimeLabel.text = ""
//                } else {
//                    cell.selectedTimeLabel.text = self.selectedStringDate
//                }
//            }
//            return cell
//            
//        default:
//            return UITableViewCell.init()
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0:
//            break
//            
//        case 1:
//            if agreeFlag == true {
//                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingAlarmDetailVC") as? SettingAlarmDetailVC {
//                    vc.modalTransitionStyle = .crossDissolve
//                    vc.modalPresentationStyle = .overCurrentContext
//                    vc.delegate = self
//                    vc.selectedTime = self.selectedDate ?? Date()
//                    if let date = selectedDate {
//                        vc.selectedTime = date
//                    }
//                    self.present(vc, animated: true, completion: nil)
//                }
//            } else {
//                break
//            }
//        default:
//            break
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 55
//    }
//}
//
//extension SettingAlarmVC: SendDataDelegate {
//    func sendData(_ date: Date) {
//        self.selectedDate = date
//
//        self.selectedTimeHour = Int(changeDateToString(date: self.selectedDate ?? Date(), formatString: "hh")) ?? -1
//        self.selectedTimeMinute = Int(changeDateToString(date: self.selectedDate ?? Date(), formatString: "mm")) ?? -1
//        LocalDataStore.localDataStore.setPushAlarmTime(newData: AlarmTimeEntity(hour: self.selectedTimeHour, minute: self.selectedTimeMinute))
//        
//        selectedStringDate = changeDateToString(date: self.selectedDate ?? Date(), formatString: "a hh시 mm분")
//        sendNotification()
//        self.alarmTableView.reloadData()
//        
//    }
//    
//}
