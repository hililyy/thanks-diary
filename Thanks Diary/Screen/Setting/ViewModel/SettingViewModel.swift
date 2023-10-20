//
//  SettingViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/22.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingViewModel {
    
    var disposeBag = DisposeBag()
    
    var selectedTime: Date? = UserDefaultManager.instance.pushTime
    
    var suggestData = BehaviorRelay<[SettingSuggestModel]>(value: [])
    
    func getSuggestDatas() {
        FirebaseManager.instance?.getSuggestDatasRx()
            .bind(to: suggestData)
            .disposed(by: disposeBag)
    }
    
    func setSuggestData(contents: String) {
        FirebaseManager.instance?.addSuggestData(contents: contents)
    }
    
    let colorSubject = PublishSubject<UIColor>()
    
    let settingTableTitles: [SettingNameModel] = [
        SettingNameModel(title: L10n.settingName1, contents: "", type: ._switch),
        SettingNameModel(title: L10n.settingName2, contents: "", type: .more),
        SettingNameModel(title: L10n.settingName3, contents: "", type: .more),
        SettingNameModel(title: L10n.settingName4, contents: "", type: .more),
        SettingNameModel(title: L10n.settingName11, contents: "", type: .more)
    ]
}
