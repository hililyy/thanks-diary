//
//  SettingAlarmDetailVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import UIKit
import UserNotifications

final class SettingAlarmDetailVC: BaseVC {
    
    // MARK: - Property
    
    private let settingAlarmDetailView = SettingAlarmDetailView()
    var viewModel: SettingViewModel?
    var delegate: ReloadDelegate?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingAlarmDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingAlarmDetailView.setDatepickerDate(date: viewModel?.selectedTime)
        setTarget()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        settingAlarmDetailView.datePickerHandler = { time in
            self.viewModel?.selectedTime = time
        }
        
        settingAlarmDetailView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                self.dismissVC()
            })
            .disposed(by: disposeBag)
        
        settingAlarmDetailView.okButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                let time = viewModel?.selectedTime ?? Date()
                self.dismissVC {
                    UserDefaultManager.instance?.set(time, key: UserDefaultKey.PUSH_TIME.rawValue)
                    LocalNotificationManager.instance?.registNotification(time: time)
                    self.viewModel?.selectedTime = time
                    self.delegate?.reload()
                }
            })
            .disposed(by: disposeBag)
        
        settingAlarmDetailView.cancelButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                self.dismissVC()
            })
            .disposed(by: disposeBag)
    }
}
