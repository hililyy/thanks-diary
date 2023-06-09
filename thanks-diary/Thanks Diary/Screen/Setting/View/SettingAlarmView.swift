//
//  SettingAlarmView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/26.
//

import UIKit

class SettingAlarmView: NSObject {
    private var settingAlarmVC: SettingAlarmVC
    private let settingModel = SettingModel.model
    
    init(_ vc: SettingAlarmVC) {
        self.settingAlarmVC = vc
    }
    
    func changeDateToString(date: Date, formatString: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = formatString
        return dateFormatter.string(from: date)
    }
}

extension SettingAlarmView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = settingAlarmVC.alarmTableView.dequeueReusableCell(withIdentifier: "AlarmSettingCell", for: indexPath) as! AlarmSettingCell
            if settingAlarmVC.agreeFlag == false {
                cell.alarmSwitchBtn.isEnabled = false
            } else {
                cell.alarmSwitchBtn.isOn = settingAlarmVC.switchFlag
            }
            return cell
        case 1:
            let cell = settingAlarmVC.alarmTableView.dequeueReusableCell(withIdentifier: "AlarmTimeCell", for: indexPath) as! AlarmTimeCell
            cell.selectionStyle = .none
            if settingAlarmVC.agreeFlag == false {
                cell.selectedTimeLabel.text = "설정에서 알림을 허용해 주세요."
            } else {
                if LocalDataStore.localDataStore.getPushAlarmTime()?.hour == -1 {
                    cell.selectedTimeLabel.text = ""
                } else {
                    cell.selectedTimeLabel.text = settingAlarmVC.selectedStringDate
                }
            }
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
            if settingAlarmVC.agreeFlag == true {
                guard let date = settingAlarmVC.selectedDate else { return }
                settingAlarmVC.presentSettingAlarmDetailVC(selectedDate: date)
            } else { break }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension SettingAlarmView: SendDataDelegate {
    func sendData(_ date: Date) {
        settingAlarmVC.selectedDate = date
        
        settingAlarmVC.selectedTimeHour = Int(changeDateToString(date: settingAlarmVC.selectedDate ?? Date(), formatString: "hh")) ?? -1
        settingAlarmVC.selectedTimeMinute = Int(changeDateToString(date: settingAlarmVC.selectedDate ?? Date(), formatString: "mm")) ?? -1
        LocalDataStore.localDataStore.setPushAlarmTime(newData: AlarmTimeEntity(hour: settingAlarmVC.selectedTimeHour, minute: settingAlarmVC.selectedTimeMinute))
        
        settingAlarmVC.selectedStringDate = changeDateToString(date: settingAlarmVC.selectedDate ?? Date(), formatString: "a hh시 mm분")
        settingAlarmVC.sendNotification()
        settingAlarmVC.alarmTableView.reloadData()
    }
}
