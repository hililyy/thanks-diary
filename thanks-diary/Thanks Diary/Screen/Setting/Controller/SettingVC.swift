//
//  SettingVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit
import AcknowList

final class SettingVC: BaseVC {
    
    // MARK: - Property
    
    var alarmFlag: Bool = false
    let settingView = SettingView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingView.tableView.dataSource = self
        settingView.tableView.delegate = self
        
        setTarget()
        setPWSwitch()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        settingView.backButtonTapHandler = {
            self.popVC()
        }
    }
    
    private func setPWSwitch() {
        self.alarmFlag = UserDefaultManager.bool(forKey: UserDefaultKey.IS_PASSWORD)
    }
}

// MARK: - UITableView

extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingSwitchTVCell.id, for: indexPath) as! SettingSwitchTVCell
            cell.titleLabel.text = "암호 설정"
            if !UserDefaultManager.bool(forKey: UserDefaultKey.IS_PASSWORD) {
                cell.settingSwitch.isOn = false
            } else {
                cell.settingSwitch.isOn = true
            }
            
            cell.switchTapHandler = {
                self.alarmFlag = !self.alarmFlag
                
                UserDefaultManager.set(self.alarmFlag, forKey: UserDefaultKey.IS_PASSWORD)
                
                if UserDefaultManager.bool(forKey: UserDefaultKey.IS_PASSWORD) {
                    let vc = SettingPWVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            return cell
            
        case 1:
            let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingMoreTVCell.id, for: indexPath) as! SettingMoreTVCell
            cell.titleLabel.text = "알림 설정"
            return cell
            
        case 2:
            let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingMoreTVCell.id, for: indexPath) as! SettingMoreTVCell
            cell.titleLabel.text = "오픈소스 라이선스"
            return cell
        
        case 3:
            let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingLabelTVCell.id, for: indexPath) as! SettingLabelTVCell
            cell.titleLabel.text = "앱 버전"
            cell.contentsLabel.text = CommonUtilManager.shared.getAppVersion()
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // 암호
            break
            
        case 1: // 알림
            let vc = SettingAlarmVC()
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case 2: // 오픈소스 라이선스
            let acknowList = AcknowListViewController(fileNamed: "Pods-Thanks Diary-acknowledgements")
                    navigationController?.pushViewController(acknowList, animated: true)
            break
            
        case 3: // 앱 버전
            break
            
        default:
            break
        }
    }
}