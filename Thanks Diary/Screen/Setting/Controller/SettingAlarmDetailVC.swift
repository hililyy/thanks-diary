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
//    var delegate: reloadDelegate?
    
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
        settingAlarmDetailView.backButtonTapHandler = {
            self.dismissVC()
        }
        
        settingAlarmDetailView.okButtonTapHandler = { time in
            self.dismissVC {
                UserDefaultManager.instance?.set(time, key: UserDefaultKey.PUSH_TIME.rawValue)
                LocalNotificationManager.instance?.requestSendNotification(time: time)
                self.viewModel?.selectedTime = time
//                self.delegate?.reloadData()
            }
        }
        
        settingAlarmDetailView.cancelButtonTapHandler = {
            self.dismissVC()
        }
    }
}