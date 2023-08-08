//
//  SettingViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/22.
//

import Foundation

class SettingViewModel {
    var selectedTime: Date? = UserDefaultManager.date(forKey: UserDefaultKey.PUSH_TIME)
}
