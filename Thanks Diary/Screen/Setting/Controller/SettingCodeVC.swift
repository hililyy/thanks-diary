//
//  SettingCodeVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/11/13.
//

import UIKit
import LocalAuthentication

final class SettingCodeVC: BaseVC<SettingView> {
    
    // MARK: - Property
    
    private var alarmFlag: Bool = false
    var viewModel: SettingViewModel?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        changePasswordData()
    }
    
    // MARK: - Function

    private func changePasswordData() {
        let password = UserDefaultManager.instance.password
        if password.isEmpty {
            UserDefaultManager.instance.isPassword = false
        }
        
        let isPassword = UserDefaultManager.instance.isPassword
        alarmFlag = isPassword
        
        attachedView.tableView.reloadData()
    }
}

// MARK: - UITableView

extension SettingCodeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = attachedView.tableView.dequeueReusableCell(withIdentifier: SettingSwitchTVCell.id, for: indexPath) as? SettingSwitchTVCell else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = L10n.settingName12
            cell.settingSwitch.isOn = alarmFlag
            
            cell.switchTapHandler = { [weak self] in
                guard let self else { return }
                
                alarmFlag.toggle()
                UserDefaultManager.instance.isPassword = alarmFlag
                
                if alarmFlag {
                    pushSettingPWVC()
                } else {
                    UserDefaultManager.instance.password = ""
                }
            }
            
        case 1:
            cell.titleLabel.text = L10n.settingName13
            cell.settingSwitch.isOn = UserDefaultManager.instance.isBiometricsAuth
            
            cell.switchTapHandler = { [weak self] in
                guard let self else { return }
                UserDefaultManager.instance.isBiometricsAuth = cell.settingSwitch.isOn
                if cell.settingSwitch.isOn {
                    AuthManager.instance.execute { [weak self] result in
                        guard let self else { return }
                        
                        if result {
                            UserDefaultManager.instance.isBiometricsAuth = true
                        } else {
                            showErrorPopup()
                        }
                    }
                }
            }
            
        default:
            break
        }
        return cell
    }
}

// MARK: - initalize

extension SettingCodeVC {
    private func initalize() {
        initDelegate()
        initTarget()
        initNavigationTitle()
    }
    
    private func initView() {
        attachedView.tableView.reloadData()
        initNavigationTitle()
    }
    
    private func initDelegate() {
        attachedView.tableView.dataSource = self
        attachedView.tableView.delegate = self
    }
    
    private func initTarget() {
        attachedView.navigationView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initNavigationTitle() {
        attachedView.setNavigationTitle(title: L10n.settingName11)
    }
}

// MARK: - View Change

extension SettingCodeVC {
    private func pushSettingPWVC() {
        let vc = SettingPWVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
