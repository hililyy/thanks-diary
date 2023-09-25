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
        settingAlarmView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                self.popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func changeDateToString(date: Date, formatString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        return dateFormatter.string(from: date)
    }
    
    private func setNotification(isOn: Bool) {
        if isOn {
            LocalNotificationManager.instance?.registNotification(time: Date())
            UserDefaultManager.instance?.set(Date(), key: UserDefaultKey.PUSH_TIME.rawValue)
            UserDefaultManager.instance?.set(true, key: UserDefaultKey.IS_PUSH.rawValue)
            self.viewModel?.selectedTime = Date()
            self.switchFlag = true
            
        } else {
            LocalNotificationManager.instance?.cancelRegistedNotification()
            UserDefaultManager.instance?.delete(UserDefaultKey.PUSH_TIME.rawValue)
            UserDefaultManager.instance?.set(false, key: UserDefaultKey.IS_PUSH.rawValue)
            self.viewModel?.selectedTime = nil
            self.switchFlag = false
        }
        
        self.reload()
    }
    
    private func showSettingAlert() {
        DispatchQueue.main.async {
            let vc = AlertVC()
            vc.alertView.setText(message: L10n.appSetting1, leftButtonText: L10n.cancel, rightButtonText: L10n.appSetting2)
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
            cell.titleLabel.text = L10n.settingName2
            cell.settingSwitch.isOn = switchFlag
            
            cell.switchTapHandler = {
                AuthManager.instance?.getNotiStatus { status in
                    
                    switch status {
                    case .authorized:
                        guard let isPush = UserDefaultManager.instance?.bool(UserDefaultKey.IS_PUSH.rawValue) else { return }
                        UserDefaultManager.instance?.set(!isPush, key: UserDefaultKey.IS_PUSH.rawValue)
                        self.switchFlag = !isPush
                        
                        // on -> off로 가는 상황
                        if isPush {
                            self.setNotification(isOn: false)
                        // off -> on으로 가는 상황
                        } else {
                            self.setNotification(isOn: true)
                        }
                        
                        self.reload()
                    case .denied:
                        self.switchFlag = false
                        self.showSettingAlert()
                        self.reload()
                    default:
                        AuthManager.instance?.requestNotiAuth(completion: { result in
                            if result {
                                self.switchFlag = true
                            } else {
                                self.switchFlag = false
                                self.showSettingAlert()
                            }
                            
                            self.reload()
                        }, errorHandler: {
                            self.showErrorPopup()
                        })
                    }
                }
            }
            
            return cell

        case 1:
            let cell = settingAlarmView.tableView.dequeueReusableCell(withIdentifier: SettingLabelTVCell.id, for: indexPath) as! SettingLabelTVCell
            cell.titleLabel.text = L10n.settingName7
            cell.contentsLabel.text = viewModel?.selectedTime?.convertString(format: Constant.AHHMM)
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
                toast(message: L10n.onAlarm,
                      withDuration: 1,
                      delay: 1,
                      positionType: PositionType.top,
                      completion: {})
            }
            
        default:
            break
        }
    }
}

// MARK: - Custom Protocol

extension SettingAlarmVC: ReloadDelegate {
    func reload() {
        DispatchQueue.main.async {
            self.settingAlarmView.tableView.reloadData()
        }
    }
}

protocol ReloadDelegate {
    func reload()
}
