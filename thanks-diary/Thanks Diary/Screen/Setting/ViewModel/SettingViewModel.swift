//
//  SettingViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/22.
//

import Foundation

final class SettingViewModel {
    var selectedTime: Date? = UserDefaultManager.date(forKey: UserDefaultKey.PUSH_TIME)
    var suggestData: [SettingSuggestModel] = []
    
    func getSuggestDatas(completion: @escaping() -> ()){
        FirebaseManager.shared.getSuggestDatas { datas in
            self.suggestData = datas
            completion()
        }
    }
    
    func setSuggestData(contents: String) {
        FirebaseManager.shared.setSuggestData(contents: contents)
    }
}
