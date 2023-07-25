//
//  SettingAlarmDetailVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import UIKit

final class SettingAlarmDetailVC: BaseVC {
    
    // MARK: - Property
    
    var selectedTime: Date?
    weak var delegate: SendDataDelegate?
    let settingAlarmDetailView = SettingAlarmDetailView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingAlarmDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    func addTarget() {
        settingAlarmDetailView.cancelButton.addTarget {
            self.dismissVC()
        }
        settingAlarmDetailView.backButton.addTarget {
            self.dismissVC()
        }
        settingAlarmDetailView.okButton.addTarget {
            self.dismissVC() {
                self.delegate?.sendData(self.selectedTime ?? Date())
            }
        }
    }
}

// MARK: - Custom Delegate

protocol SendDataDelegate: AnyObject {
    func sendData (_ date: Date)
}
