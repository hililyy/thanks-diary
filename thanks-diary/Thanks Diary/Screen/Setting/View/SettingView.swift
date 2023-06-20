//
//  SettingView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/22.
//

import UIKit
import MessageUI
import AcknowList

final class SettingView: NSObject {
    private var settingVC: SettingVC
    private let settingModel = SettingModel.model
    let mainModel = MainModel.model
    
    init(_ settingVC: SettingVC) {
        self.settingVC = settingVC
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
        guard let appStoreVersion = results[0]["version"] as? String else { return "" }
        return appStoreVersion
    }
}

extension SettingView: UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = settingVC.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "계정 설정"
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = settingVC.settingTableView.dequeueReusableCell(withIdentifier: "SettingSwitchCell", for: indexPath) as! SettingSwitchCell
            cell.settingLabel.text = "암호 설정"
            if LocalDataStore.localDataStore.getPasswordData() == false {
                cell.settingSwitch.isOn = false
            } else {
                cell.settingSwitch.isOn = true
            }
            
            return cell
//        case 2:
//            let cell = settingVC.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
//            cell.settingLabel.text = "알림 설정"
//            cell.selectionStyle = .none
//            return cell
            
        case 2:
            let cell = settingVC.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "고객 센터"
            cell.selectionStyle = .none
            return cell
            
        case 3:
            let cell = settingVC.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "오픈소스 라이선스"
            cell.selectionStyle = .none
            return cell
            
        case 4:
            let appVersion = loadAppStoreVersion()
            let cell = settingVC.settingTableView.dequeueReusableCell(withIdentifier: "SettingLabelCell", for: indexPath) as! SettingLabelCell
            cell.settingLabel.text = "앱 버전"
            cell.settingDetailLabel.text = "\(appVersion)"
            return cell
        case 5:
            let cell = settingVC.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "기존 데이터 불러오기"
            cell.selectionStyle = .none
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
            settingVC.showSettingUserInfoVC()
            break
            
        case 1: // 암호
            break
            
//        case 2: // 알림
//            settingVC.showSettingAlarmVC()
//            break
            
        case 2: // 고객센터
            if MFMailComposeViewController.canSendMail() {
                let compseVC = MFMailComposeViewController()
                compseVC.mailComposeDelegate = self
                compseVC.setToRecipients(["joun406@gmail.com"])
                settingVC.present(compseVC, animated: true, completion: nil)
            }
            break
            
        case 3: // 오픈소스 라이선스
            let acknowList = AcknowListViewController(fileNamed: "Pods-Thanks Diary-acknowledgements")
            settingVC.navigationController?.pushViewController(acknowList, animated: true)
            break
            
        case 4: // 앱 버전
            break
        case 5:
            AlertManager.shared.okCancelAlert(self.settingVC, title: "알림", message: "백업되지 않은 데이터가 있으면 백업합니다.") {
                self.mainModel.uploadData()
            }
            
        default: break
        }
    }
}
