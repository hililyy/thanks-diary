//
//  SettingViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/22.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel {
    
    var disposeBag = DisposeBag()
    var selectedTime: Date? = UserDefaultManager.instance?.date(UserDefaultKey.PUSH_TIME.rawValue)
    var suggestData = BehaviorRelay<[SettingSuggestModel]>(value: [])
    let alarmTableTitles = BehaviorRelay<[SettingNameModel]>(value: [
        SettingNameModel(title: "text_setting_name7".localized, contents: "", type: ._switch),
        SettingNameModel(title: "text_setting_name2".localized, contents: "", type: .more)
    ])
    
    func getSuggestDatas() {
        FirebaseManager.instance?.getSuggestDatasRx()
            .bind(to: suggestData)
            .disposed(by: disposeBag)
    }
    
    func setSuggestData(contents: String) {
        FirebaseManager.instance?.addSuggestData(contents: contents)
    }
}
