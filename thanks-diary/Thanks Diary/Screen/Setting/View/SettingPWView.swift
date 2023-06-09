//
//  SettingPWView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/23.
//

import UIKit

final class SettingPWView: NSObject {
    private var settingPWVC: SettingPWVC
    private let settingModel = SettingModel.model
    
    init(_ settingPWVC: SettingPWVC) {
        self.settingPWVC = settingPWVC
    }
}
