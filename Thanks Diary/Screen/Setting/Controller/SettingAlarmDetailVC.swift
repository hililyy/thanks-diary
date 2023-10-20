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
    var delegate: ReloadProtocol?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingAlarmDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    // MARK: - Function
    
    private func savePushTime() {
        let time = viewModel?.selectedTime ?? Date()
        UserDefaultManager.instance.pushTime = time
        LocalNotificationManager.instance?.registNotification(time: time)
        self.viewModel?.selectedTime = time
    }
}

// MARK: - initalize

extension SettingAlarmDetailVC {
    private func initalize() {
        initUI()
        initTarget()
    }
    
    private func initUI() {
        settingAlarmDetailView.setDatepickerDate(date: viewModel?.selectedTime)
    }
    
    private func initTarget() {
        initDatePickerHandler()
        initBackButtonTarget()
        initOkButtonTarget()
        initCancelButtonTarget()
    }
    
    private func initDatePickerHandler() {
        settingAlarmDetailView.datePickerHandler = { [weak self] time in
            guard let self else { return }
            viewModel?.selectedTime = time
        }
    }
    
    private func initBackButtonTarget() {
        settingAlarmDetailView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                dismissVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initOkButtonTarget() {
        settingAlarmDetailView.okButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                dismissVC {
                    self.savePushTime()
                    self.delegate?.reload()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func initCancelButtonTarget() {
        settingAlarmDetailView.cancelButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                dismissVC()
            })
            .disposed(by: disposeBag)
    }
}
