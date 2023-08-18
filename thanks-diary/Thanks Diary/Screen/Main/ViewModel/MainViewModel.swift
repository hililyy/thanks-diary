//
//  MainViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewModel {
    
    var disposeBag = DisposeBag()
    var allDetailDataRx = BehaviorRelay<[String: [DiaryModel]]>(value: [:]) // 자세한 일기 전체
    var allSimpleDataRx = BehaviorRelay<[String: [DiaryModel]]>(value: [:]) // 간단한 일기 전체

    // 선택한 날짜의 일기 데이터
    lazy var selectedAllData: Observable<[DiaryModel]> = selectedDate.map { date in
        let detailData = self.allDetailDataRx.value[date.convertString()] ?? []
        let simpleData = self.allSimpleDataRx.value[date.convertString()] ?? []
        return detailData + simpleData
    }
    
    var selectedDiaryData: DiaryModel?
    var selectedDate = BehaviorRelay<Date>(value: Date()) // 선택한 날짜
    var diaryDates: Set<String> = [] // 일기를 작성한 날짜 Set
    
    init() {
        getData()
    }
}

// 다이어리 조회, 생성, 수정, 삭제
extension MainViewModel {
    // 조회
    func getData() {
        _ = CoreDataManager.shared.getDetailDataRx()
            .bind(to: allDetailDataRx)
            .disposed(by: disposeBag)
        
        _ = CoreDataManager.shared.getSimpleDataRx()
            .bind(to: allSimpleDataRx)
            .disposed(by: disposeBag)
        
        selectedDate.accept(selectedDate.value)
    }
    
    // 저장
    func setData(newData: DiaryModel, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.setData(newData: newData) { result in
                if result {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
    
    // 수정
    func updateData(newData: DiaryModel, completion: @escaping (Bool) -> ()) {
        guard let selectedDiaryData = selectedDiaryData else { return }
        CoreDataManager.shared.updateData(beforeData: selectedDiaryData, newData: newData) { result in
            if result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    // 삭제
    func deleteData(completion: @escaping (Bool) -> ()) {
        guard let selectedDiaryData = selectedDiaryData else { return }
        CoreDataManager.shared.deleteData(deleteData: selectedDiaryData) { result in
            if result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
