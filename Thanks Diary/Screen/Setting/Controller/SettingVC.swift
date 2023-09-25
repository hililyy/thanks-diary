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
    
    private let settingView = SettingView()
    private var alarmFlag: Bool = false
    let viewModel = SettingViewModel()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingView.tableView.dataSource = self
        settingView.tableView.delegate = self
        
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let password = UserDefaultManager.instance?.string(UserDefaultKey.PASSWORD.rawValue) else { return }
        
        if password.isEmpty {
            UserDefaultManager.instance?.set(false, key: UserDefaultKey.IS_PASSWORD.rawValue)
        }
        
        guard let isPassword = UserDefaultManager.instance?.bool(UserDefaultKey.IS_PASSWORD.rawValue) else { return }
        alarmFlag = isPassword
        settingView.tableView.reloadData()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        settingView.backButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.popVC()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableView

extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingSwitchTVCell.id, for: indexPath) as! SettingSwitchTVCell
            cell.titleLabel.text = "암호 설정"
            cell.settingSwitch.isOn = alarmFlag
            
            cell.switchTapHandler = {
                self.alarmFlag = !self.alarmFlag
                UserDefaultManager.instance?.set(self.alarmFlag, key: UserDefaultKey.IS_PASSWORD.rawValue)
                if self.alarmFlag {
                    let vc = SettingPWVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    UserDefaultManager.instance?.set("", key: UserDefaultKey.PASSWORD.rawValue)
                }
            }
            
            return cell
            
        case 1:
            let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingMoreTVCell.id, for: indexPath) as! SettingMoreTVCell
            cell.titleLabel.text = "알림 설정"
            return cell
            
        case 2:
            let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingMoreTVCell.id, for: indexPath) as! SettingMoreTVCell
            cell.titleLabel.text = "테마 설정"
            return cell
            
        case 3:
            let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingMoreTVCell.id, for: indexPath) as! SettingMoreTVCell
            cell.titleLabel.text = "건의사항"
            return cell
            
        case 4:
            let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingMoreTVCell.id, for: indexPath) as! SettingMoreTVCell
            cell.titleLabel.text = "오픈소스 라이선스"
            return cell
            
        case 5:
            let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingLabelTVCell.id, for: indexPath) as! SettingLabelTVCell
            cell.titleLabel.text = "앱 버전"
            cell.contentsLabel.text = CommonUtilManager.instance?.appVersion
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
            vc.viewModel = viewModel
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2: // 테마 설정
            let vc = SettingThemeVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3: // 건의하기
            let vc = SettingSuggestVC()
            vc.viewModel = viewModel
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 4: // 오픈소스 라이선스
            let acknowList = AcknowListViewController(fileNamed: "Pods-Thanks Diary-acknowledgements")
                    navigationController?.pushViewController(acknowList, animated: true)
                  
        case 5: // 앱 버전
            LocalNotificationManager.instance?.printRegistedNotification()
            
        default:
            break
        }
    }
}
