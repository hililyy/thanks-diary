//
//  SettingAlarmVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import UIKit

final class SettingAlarmVC: BaseVC {
    
    // MARK: - Property
    
    let settingAlarmView = SettingAlarmView()
    var viewModel: SettingViewModel?
    var switchFlag: Bool = false
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTarget()
        settingAlarmView.tableView.dataSource = self
        settingAlarmView.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AuthManager.instance?.getNotiStatus { status in
            if status == .denied {
                self.setNotification(isOn: false)
            } else {
                guard let isPush = UserDefaultManager.instance?.bool(UserDefaultKey.IS_PUSH.rawValue) else { return }
                self.switchFlag = isPush
            }
        }
    }
    
    // MARK: - Function
    
    private func setTarget() {
//        settingAlarmView.backButtonTapHandler = {
//            self.popVC()
//        }
    }
    
    private func changeDateToString(date: Date, formatString: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = formatString
        return dateFormatter.string(from: date)
    }
    
    private func setNotification(isOn: Bool) {
        if isOn {
            LocalNotificationManager.shared.requestSendNotification(time: Date())
            UserDefaultManager.set(Date(), forKey: UserDefaultKey.PUSH_TIME)
            UserDefaultManager.set(true, forKey: UserDefaultKey.IS_PUSH)
            self.viewModel?.selectedTime = Date()
            self.switchFlag = true
            
        } else {
            LocalNotificationManager.shared.removePendingNotification()
            UserDefaultManager.delete(forKey: UserDefaultKey.PUSH_TIME)
            UserDefaultManager.set(false, forKey: UserDefaultKey.IS_PUSH)
            self.viewModel?.selectedTime = nil
            self.switchFlag = false
        }
        
        self.reloadData()
    }
    
    private func showSettingAlert() {
        DispatchQueue.main.async {
            let vc = AlertVC()
            vc.alertView.setText(message: "text_app_setting_1".localized, leftButtonText: "text_cancel".localized, rightButtonText: "text_app_setting_2".localized)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.rightButtonTapHandler = {
                self.goAppSetting()
            }
            self.present(vc, animated: true)
        }
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
            
            cell.switchTapHandler = {
                AuthManager.shared.getNotiStatus { status in
                    
                    switch status {
                        
                    case .authorized:
                        let isPush = UserDefaultManager.bool(forKey: UserDefaultKey.IS_PUSH)
                        UserDefaultManager.set(!isPush, forKey: UserDefaultKey.IS_PUSH)
                        self.switchFlag = !isPush
                        
                        // on -> off로 가는 상황
                        if isPush {
                            self.setNotification(isOn: false)
                        // off -> on으로 가는 상황
                        } else {
                            self.setNotification(isOn: true)
                        }
                        
                        self.reloadData()
                        
                    case .denied:
                        self.switchFlag = false
                        self.showSettingAlert()
                        self.reloadData()
                        
                    default:
                        AuthManager.shared.requestNotiAuth(completion: { result in
                            if result {
                                self.switchFlag = true
                            } else {
                                self.switchFlag = false
                                self.showSettingAlert()
                            }
                            
                            self.reloadData()
                        }, errorHandler: {
                            self.showErrorPopup()
                        })
                    }
                }
            }
            
            return cell

        case 1:
            let cell = settingAlarmView.tableView.dequeueReusableCell(withIdentifier: SettingLabelTVCell.id, for: indexPath) as! SettingLabelTVCell
            cell.titleLabel.text = "시간 설정"
            cell.contentsLabel.text = viewModel?.selectedTime?.convertString(format: "a hh시 mm분")
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
            if switchFlag {
                let vc = SettingAlarmDetailVC()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overCurrentContext
                vc.delegate = self
                vc.viewModel = self.viewModel
                self.present(vc, animated: true)
            } else {
                toast(message: "text_on_alarm".localized, withDuration: 1, delay: 1, type: "top", completion: {})
            }
            
        default:
            break
        }
    }
}

// MARK: - Custom Protocol

extension SettingAlarmVC: reloadDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.settingAlarmView.tableView.reloadData()
        }
    }
}
