//
//  SettingCodeVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/11/13.
//

import UIKit
import LocalAuthentication
import FirebaseAnalytics

final class SettingCodeVC: BaseVC<SettingView> {
    
    // MARK: - Property
    
    private var alarmFlag: Bool = false
    var viewModel: SettingViewModel
    
    // MARK: - Init
    
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Analytics.logEvent("settingCode", parameters: nil)
        
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
        
        alarmFlag = UserDefaultManager.instance.isPassword
        
        attachedView.tableView.reloadData()
    }
}

// MARK: - UITableView

extension SettingCodeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = attachedView.tableView.dequeueReusableCell(withIdentifier: SettingSwitchTVCell.id,
                                                                    for: indexPath) as? SettingSwitchTVCell
        else { return UITableViewCell() }
        
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
                    bioAuth()
                }
            }
            
        default:
            break
        }
        
        return cell
    }
    
    private func bioAuth() {
        AuthManager.instance.executeBioAuth { [weak self] result in
            guard let self else { return }
            
            if result {
                UserDefaultManager.instance.isBiometricsAuth = true
            } else {
                UserDefaultManager.instance.isBiometricsAuth = false
                showAlert(message: L10n.alertBioauth,
                          leftButtonText: L10n.no,
                          rightButtonText: L10n.retry,
                          leftButtonHandler: {
                    self.attachedView.tableView.reloadData()
                },
                          rightButtonHandler: {
                    self.bioAuth()
                })
            }
        }
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
