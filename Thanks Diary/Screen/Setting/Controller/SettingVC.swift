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
        
        initTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let password = UserDefaultManager.instance?.string(UserDefaultKey.PASSWORD.rawValue),
            password.isEmpty {
            UserDefaultManager.instance?.set(false, key: UserDefaultKey.IS_PASSWORD.rawValue)
        }
        
        if let isPassword = UserDefaultManager.instance?.bool(UserDefaultKey.IS_PASSWORD.rawValue) {
            alarmFlag = isPassword
        }
        
        settingView.tableView.reloadData()
    }
    
    // MARK: - Function
    
    private func initTarget() {
        settingView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                popVC()
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
        let data = settingView.settingTableTitles[indexPath.row]
        
        switch data.type {
        case ._switch:
            guard let cell = settingView.tableView.dequeueReusableCell(withIdentifier: SettingSwitchTVCell.id, for: indexPath) as? SettingSwitchTVCell else { return UITableViewCell() }
            cell.titleLabel.text = data.title
            cell.settingSwitch.isOn = alarmFlag
            
            cell.switchTapHandler = { [weak self] in
                guard let self else { return }
                alarmFlag = !alarmFlag
                UserDefaultManager.instance?.set(alarmFlag, key: UserDefaultKey.IS_PASSWORD.rawValue)
                if alarmFlag {
                    let vc = SettingPWVC()
                    navigationController?.pushViewController(vc, animated: true)
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
        case 0: // 암호
            break
            
        case 1: // 알림
            let vc = SettingAlarmVC()
            vc.viewModel = viewModel
            navigationController?.pushViewController(vc, animated: true)
            
        case 2: // 테마 설정
            let vc = SettingThemeVC()
            navigationController?.pushViewController(vc, animated: true)
            
        case 3: // 건의하기
            let vc = SettingSuggestVC()
            vc.viewModel = viewModel
            navigationController?.pushViewController(vc, animated: true)
            
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
