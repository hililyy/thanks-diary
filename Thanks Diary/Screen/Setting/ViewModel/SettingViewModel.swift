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
        SettingNameModel(title: L10n.settingName7, contents: "", type: ._switch),
        SettingNameModel(title: L10n.settingName2, contents: "", type: .more)
    ])
    
    let settingTableTitles = BehaviorRelay<[SettingNameModel]>(value: [
        SettingNameModel(title: L10n.settingName1, contents: "", type: ._switch),
        SettingNameModel(title: L10n.settingName2, contents: "", type: .more),
        SettingNameModel(title: L10n.settingName3, contents: "", type: .more),
        SettingNameModel(title: L10n.settingName4, contents: "", type: .more),
        SettingNameModel(title: L10n.settingName5, contents: "", type: .more),
        SettingNameModel(title: L10n.settingName6, contents: "", type: .label)
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
