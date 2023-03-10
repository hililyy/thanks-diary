//
//  SettingVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit
import AcknowList
import MessageUI

class SettingVC: UIViewController, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate {
    
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
            showSettingPWVC()
        }
    }
    
    func setPWSwitch() {
        self.alarmFlag = LocalDataStore.localDataStore.getPasswordData()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func loadAppStoreVersion() -> String {
        let bundleID = "com.lily.Thanks-Diary"
        let appStoreUrl = "http://itunes.apple.com/lookup?bundleId=\(bundleID)"
        guard let url = URL(string: appStoreUrl),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
              let results = json["results"] as? [[String: Any]] else {
            return ""
        }
        
        guard let appStoreVersion = results[0]["version"] as? String else {
            return ""
        }
        
        return appStoreVersion
    }
}
extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "계정 설정"
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingSwitchCell", for: indexPath) as! SettingSwitchCell
            cell.settingLabel.text = "암호 설정"
            if LocalDataStore.localDataStore.getPasswordData() == false {
                cell.settingSwitch.isOn = false
            } else {
                cell.settingSwitch.isOn = true
            }
            
            return cell
        case 2:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "알림 설정"
            cell.selectionStyle = .none
            return cell
            
        case 3:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "고객 센터"
            cell.selectionStyle = .none
            return cell
            
        case 4:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "오픈소스 라이선스"
            cell.selectionStyle = .none
            return cell
            
        case 5:
            let appVersion = loadAppStoreVersion()
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingLabelCell", for: indexPath) as! SettingLabelCell
            cell.settingLabel.text = "앱 버전"
            cell.settingDetailLabel.text = "\(appVersion)"
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
        case 0: // 계정 설정
            showSettingUserInfoVC()
            break
            
        case 1: // 암호
            break
            
        case 2: // 알림
            showSettingAlarmVC()
            break
            
        case 3: // 고객센터
            if MFMailComposeViewController.canSendMail() {
                let compseVC = MFMailComposeViewController()
                compseVC.mailComposeDelegate = self
                compseVC.setToRecipients(["joun406@gmail.com"])
                self.present(compseVC, animated: true, completion: nil)
            }
            break
            
        case 4: // 오픈소스 라이선스
//            let acknowList = AcknowListViewController(fileNamed: "Pods-Thanks Diary-acknowledgements")
//            navigationController?.pushViewController(acknowList, animated: true)
            break
            
        case 5: // 앱 버전
            break
            
        default: break
        }
    }
}


