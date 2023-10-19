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
    
    private var settingView = SettingView()
    private var alarmFlag: Bool = false
    let viewModel = SettingViewModel()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
        
        CommonUtilManager.instance?.themeSubject.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            settingView = SettingView()
            view = settingView
            initalize()
        })
        .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changePasswordData()
    }
    
    // MARK: - Function

    private func changePasswordData() {
        if let password = UserDefaultManager.instance?.string(UserDefaultKey.PASSWORD.rawValue),
            password.isEmpty {
            UserDefaultManager.instance?.set(false, key: UserDefaultKey.IS_PASSWORD.rawValue)
        }
        
        if let isPassword = UserDefaultManager.instance?.bool(UserDefaultKey.IS_PASSWORD.rawValue) {
            alarmFlag = isPassword
        }
        
        settingView.tableView.reloadData()
    }
}

// MARK: - UITableView

extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = settingView.settingTableTitles[indexPath.row]
        
        switch data.type {
        case ._switch:
            guard let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingSwitchTVCell.id, for: indexPath) as? SettingSwitchTVCell else { return UITableViewCell() }
            cell.titleLabel.text = data.title
            cell.settingSwitch.isOn = alarmFlag
            
            cell.switchTapHandler = { [weak self] in
                guard let self else { return }
                alarmFlag.toggle()
                UserDefaultManager.instance?.set(alarmFlag, key: UserDefaultKey.IS_PASSWORD.rawValue)
                if alarmFlag {
                    pushSettingPWVC()
                } else {
                    UserDefaultManager.instance?.set("", key: UserDefaultKey.PASSWORD.rawValue)
                }
            }
            return cell
            
        case .more:
            guard let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingMoreTVCell.id, for: indexPath) as? SettingMoreTVCell else { return UITableViewCell() }
            cell.titleLabel.text = data.title
            return cell
            
        case .label:
            guard let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingLabelTVCell.id, for: indexPath) as? SettingLabelTVCell else { return UITableViewCell() }
            cell.titleLabel.text = data.title
            cell.contentsLabel.text = data.contents
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            pushSettingAlarmVC()
        case 2:
            pushSettingThemeVC()
        case 3:
            pushSettingSuggestVC()
        case 4:
            pushOpenSourceLicenseVC()
        case 5:
            LocalNotificationManager.instance?.printRegistedNotification()
        default:
            break
        }
    }
}

// MARK: - initalize

extension SettingVC {
    private func initalize() {
        initDelegate()
        initTarget()
    }
    
    private func initDelegate() {
        settingView.tableView.dataSource = self
        settingView.tableView.delegate = self
    }
    
    private func initTarget() {
        settingView.navigationView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                popVC()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - View Change

extension SettingVC {
    private func pushSettingPWVC() {
        let vc = SettingPWVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushSettingAlarmVC() {
        let vc = SettingAlarmVC()
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushSettingThemeVC() {
        let vc = SettingThemeVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushSettingSuggestVC() {
        let vc = SettingSuggestVC()
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushOpenSourceLicenseVC() {
        let acknowList = AcknowListViewController(fileNamed: "Package")
        navigationController?.pushViewController(acknowList, animated: true)
    }
}
