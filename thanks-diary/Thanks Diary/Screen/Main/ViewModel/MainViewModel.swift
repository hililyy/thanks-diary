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
        guard let detailData = self.allDetailDataRx.value[date.convertString()],
              let simpleData = self.allSimpleDataRx.value[date.convertString()] else { return [] }
        return detailData + simpleData
    }
    
    var selectedDate = BehaviorRelay<Date>(value: Date()) // 선택한 날짜
    var diaryDates: Set<String> = [] // 일기를 작성한 날짜 Set
    var selectedIndex: Int = 0
    
    init() {
        getData()
    }
    
    func getData() {
        _ = CoreDataManager.shared.getDetailDataRx()
            .bind(to: allDetailDataRx)
            .disposed(by: disposeBag)
        
        _ = CoreDataManager.shared.getSimpleDataRx()
            .bind(to: allSimpleDataRx)
            .disposed(by: disposeBag)
    }
    
}

// 다이어리 생성, 수정, 삭제 (자세)
extension MainViewModel {
    // 저장(자세)
    func setDetailData(newData: DiaryModel, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.setData(
            newData: newData) { result in
                if result {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
    
    // 수정(자세)
    func updateDetailData(beforeData: DiaryModel, newData: DiaryModel, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.updateData(beforeData: beforeData, newData: newData) { result in
            if result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    // 삭제(자세)
    func deleteDetailData(deleteData: DiaryModel, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.deleteData(deleteData: deleteData) { result in
            if result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}


// 다이어리 생성, 수정, 삭제 (단순)
extension MainViewModel {
    // 저장(단순)
    func setSimpleData(newData: DiaryModel, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.setData(newData: newData) { result in
            if result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    // 수정(단순)
    func updateSimpleData(beforeData: DiaryModel, newData: DiaryModel, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.updateData(beforeData: beforeData, newData: newData) { result in
            if result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    // 삭제(단순)
    func deleteSimpleData(deleteData: DiaryModel, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.deleteData(deleteData: deleteData) { result in
            if result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
