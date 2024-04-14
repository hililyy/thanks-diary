//
//  SettingAlarmDetailVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import UIKit
import UserNotifications

final class SettingAlarmDetailVC: BaseVC<SettingAlarmDetailView> {
    
    // MARK: - Property
    
    var viewModel: SettingViewModel
    var delegate: ReloadProtocol?
    
    // MARK: - Init
    
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
    }
    
    // MARK: - Function
    
    private func savePushTime() {
        let time = viewModel.selectedTime ?? Date()
        UserDefaultManager.instance.pushTime = time
        LocalNotificationManager.instance.registNotification(time: time)
        viewModel.selectedTime = time
    }
}

// MARK: - initalize

extension SettingAlarmDetailVC {
    private func initalize() {
        initUI()
        initTarget()
    }
    
    private func initUI() {
        attachedView.setDatepickerDate(date: viewModel.selectedTime)
    }
    
    private func initTarget() {
        initDatePickerHandler()
        initBackButtonTarget()
        initOkButtonTarget()
        initCancelButtonTarget()
    }
    
    private func initDatePickerHandler() {
        attachedView.datePickerHandler = { [weak self] time in
            guard let self else { return }
            
            viewModel.selectedTime = time
        }
    }
    
    private func initBackButtonTarget() {
        attachedView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                dismissVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initOkButtonTarget() {
        attachedView.okButton.rx.tap
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
        attachedView.cancelButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                dismissVC()
            })
            .disposed(by: disposeBag)
    }
}
