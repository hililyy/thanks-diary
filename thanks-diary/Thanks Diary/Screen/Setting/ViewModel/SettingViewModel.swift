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
    var selectedTime: Date? = UserDefaultManager.date(forKey: UserDefaultKey.PUSH_TIME)
    var suggestData = BehaviorRelay<[SettingSuggestModel]>(value: [])
    
    func getSuggestDatas() {
        FirebaseManager.shared.getSuggestDatasRx()
            .bind(to: suggestData)
            .disposed(by: disposeBag)
    }
    
    func setSuggestData(contents: String) {
        FirebaseManager.shared.setSuggestData(contents: contents)
    }
}
