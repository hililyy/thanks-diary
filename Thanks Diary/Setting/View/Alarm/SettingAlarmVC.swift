//
//  SettingAlarmVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import UIKit

class SettingAlarmVC: UIViewController {

    @IBOutlet weak var alarmTableView: UITableView!
    var selectedDate: Date? = nil
    var selectedStringDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmTableView.dataSource = self
        alarmTableView.delegate = self
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
            return cell
        case 1:
            let cell = self.alarmTableView.dequeueReusableCell(withIdentifier: "AlarmTimeCell", for: indexPath) as! AlarmTimeCell
            cell.selectionStyle = .none
            cell.selectedTimeLabel.text = self.selectedStringDate
            return cell
        default:
            return UITableViewCell.init()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingAlarmDetailVC") as? SettingAlarmDetailVC {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.delegate = self
            if let date = selectedDate {
                vc.selectedTime = date
            }
            self.present(vc, animated: true, completion: nil)
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
