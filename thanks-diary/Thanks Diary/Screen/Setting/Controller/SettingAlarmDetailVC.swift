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
    
    let settingAlarmDetailView = SettingAlarmDetailView()
    var parentVC: SettingAlarmVC?
    var delegate: reloadDelegate?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingAlarmDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        settingAlarmDetailView.backButtonTapHandler = {
            self.dismissVC()
        }
        
        settingAlarmDetailView.okButtonTapHandler = { time in
            self.dismissVC() {
                UserDefaultManager.set(time, forKey: UserDefaultKey.PUSH_TIME)
                LocalNotificationManager.shared.requestSendNotification(time: time)
                self.parentVC?.viewModel.selectedTime = time
                self.delegate?.reloadData()
            }
        }
        
        settingAlarmDetailView.cancelButtonTapHandler = {
            self.dismissVC()
        }
    }
}
