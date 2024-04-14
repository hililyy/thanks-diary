//
//  SettingAlarmVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import UIKit

final class SettingAlarmVC: BaseVC<SettingView> {
    
    // MARK: - Property
    
    var viewModel: SettingViewModel
    var switchFlag: Bool = false
    
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
        
        initalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        changeSwitchStatusByAuthStatus()
    }
    
    // MARK: - Function
    
    private func changeSwitchStatusByAuthStatus() {
        AuthManager.instance.getNotiStatus { [weak self] status in
            guard let self else { return }
            
            if status == .denied {
                setNotification(isOn: false)
            } else {
                switchFlag = UserDefaultManager.instance.isPush
            }
        }
    }
    
    private func changeDateToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    private func setNotification(isOn: Bool) {
        if isOn {
            onNotification()
        } else {
            offNotification()
        }
        
        reload()
    }
    
    private func onNotification() {
        LocalNotificationManager.instance.registNotification(time: Date())
        UserDefaultManager.instance.pushTime = Date()
        UserDefaultManager.instance.isPush = true
        viewModel.selectedTime = Date()
        switchFlag = true
    }
    
    private func offNotification() {
        LocalNotificationManager.instance.cancelRegistedNotification()
        UserDefaultManager.instance.delete(UserDefaultKey.PUSH_TIME.rawValue)
        UserDefaultManager.instance.isPush = false
        viewModel.selectedTime = nil
        switchFlag = false
    }
    
    private func changeSwitch() {
        let isPush = UserDefaultManager.instance.isPush
        UserDefaultManager.instance.isPush = !isPush
        switchFlag = !isPush
        setNotification(isOn: switchFlag)
        reload()
    }
    
    private func induceOnSwitch() {
        switchFlag = false
        presentSettingAlertPopup()
        reload()
    }
    
    private func requestNotiAuthFromUser() {
        AuthManager.instance.requestNotiAuth(completion: { [weak self] result in
            guard let self else { return }
            
            switchFlag = result
            if !switchFlag {
                presentSettingAlertPopup()
            }
            
            reload()
        }, errorHandler: { [weak self] in
            guard let self else { return }
            
            showErrorPopup()
        })
    }
    
    private func getNotiStatus() {
        AuthManager.instance.getNotiStatus { [weak self] status in
            guard let self else { return }
            
            switch status {
            case .authorized:
                changeSwitch()
                
            case .denied:
                induceOnSwitch()
                
            default:
                requestNotiAuthFromUser()
            }
        }
    }
}

// MARK: - UITableView

extension SettingAlarmVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = attachedView.tableView.dequeueReusableCell(withIdentifier: SettingSwitchTVCell.id, 
                                                                        for: indexPath) as? SettingSwitchTVCell 
            else { return UITableViewCell() }
            
            cell.titleLabel.text = L10n.settingName2
            cell.settingSwitch.isOn = switchFlag
            cell.switchTapHandler = {
                self.getNotiStatus()
            }
            return cell

        case 1:
            guard let cell = attachedView.tableView.dequeueReusableCell(withIdentifier: SettingLabelTVCell.id, 
                                                                        for: indexPath) as? SettingLabelTVCell
            else { return UITableViewCell() }
            
            cell.titleLabel.text = L10n.settingName7
            cell.contentsLabel.text = viewModel.selectedTime?.toString(didChangeDateFormat: DateFormat.AHHMM.rawValue)
            return cell
            
        case 2:
            guard let cell = attachedView.tableView.dequeueReusableCell(withIdentifier: SettingMoreTVCell.id,
                                                                        for: indexPath) as? SettingMoreTVCell
            else { return UITableViewCell() }
            
            cell.titleLabel.text = L10n.settingName14
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            if switchFlag {
                presentSettingAlarmDetailVC()
            } else {
                toast(message: L10n.onAlarm,
                      withDuration: 1,
                      delay: 1,
                      positionType: PositionType.top,
                      completion: {})
            }
            
        case 2:
            pushSettingAlarmMessageVC()
            
        default:
            break
        }
    }
}

// MARK: - Custom Protocol

extension SettingAlarmVC: ReloadProtocol {
    func reload() {
        DispatchQueue.main.async {
            self.attachedView.tableView.reloadData()
        }
    }
}

// MARK: - initalize

extension SettingAlarmVC {
    private func initalize() {
        initTarget()
        initDelegate()
        initNavigationTitle()
    }
    
    private func initTarget() {
        initBackButtonTarget()
    }
    
    private func initBackButtonTarget() {
        attachedView.navigationView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initDelegate() {
        attachedView.tableView.dataSource = self
        attachedView.tableView.delegate = self
    }
    
    private func initNavigationTitle() {
        attachedView.setNavigationTitle(title: L10n.settingAlarm)
    }
}

// MARK: - View Change

extension SettingAlarmVC {
    private func presentSettingAlarmDetailVC() {
        let vc = SettingAlarmDetailVC(viewModel: self.viewModel)
        vc.delegate = self
        vc.viewModel = viewModel
        present(vc, animated: true)
    }
    
    private func presentSettingAlertPopup() {
        DispatchQueue.main.async {
            self.showAlert(message: L10n.appSetting1,
                      leftButtonText: L10n.cancel,
                      rightButtonText: L10n.appSetting2,
                      leftButtonHandler: {},
                      rightButtonHandler: { [weak self] in
                self?.goAppSetting()
            })
        }
    }
    
    private func pushSettingAlarmMessageVC() {
        let vc = SettingAlarmMessageVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
