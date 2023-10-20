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
}
