//
//  SettingVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

class SettingVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var settingTableView: UITableView!
    var alarmFlag: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.dataSource = self
        settingTableView.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setPWSwitch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func switchAlarm(_ sender: Any) {
        alarmFlag = !alarmFlag
        LocalDataStore.localDataStore.setPasswordData(newData: alarmFlag)
        if LocalDataStore.localDataStore.getPasswordData() == true {
            guard let vc =  storyboard?.instantiateViewController(identifier: "SettingPWVC") as? SettingPWVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setPWSwitch() {
        self.alarmFlag = LocalDataStore.localDataStore.getPasswordData()
    }
}
extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingSwitchCell", for: indexPath) as! SettingSwitchCell
            cell.settingLabel.text = "암호 설정"
            if LocalDataStore.localDataStore.getPasswordData() == false {
                cell.settingSwitch.isOn = false
            } else {
                cell.settingSwitch.isOn = true
            }
            
            return cell
        case 1:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "알림 설정"
            cell.selectionStyle = .none

            return cell
        case 2:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "오픈소스 라이선스"
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "후원하기"
            cell.selectionStyle = .none
            return cell
        
        case 4:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingLabelCell", for: indexPath) as! SettingLabelCell
            cell.settingLabel.text = "앱 버전"
            cell.settingDetailLabel.text = "1.0.0"
            return cell
        default:
            return UITableViewCell.init()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // 암호
            break
            
        case 1: // 알림
            guard let vc =  storyboard?.instantiateViewController(identifier: "SettingAlarmVC") as? SettingAlarmVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case 2: // 오픈소스 라이선스
            guard let vc =  storyboard?.instantiateViewController(identifier: "SettingOpenSourceVC") as? SettingOpenSourceVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case 3: // 후원
            guard let vc =  storyboard?.instantiateViewController(identifier: "SettingSupportVC") as? SettingSupportVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case 4: // 앱 버전
            break
            
        default: break
        }
    }
}
