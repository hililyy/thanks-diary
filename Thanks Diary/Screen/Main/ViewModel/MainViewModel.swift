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
    
    var selectedDate = BehaviorRelay<Date>(value: Date()) // 선택한 날짜
    var diaryDates: Set<String> = [] // 일기를 작성한 날짜 Set
    
    init() {
        readData()
    }
}

extension MainViewModel: DiaryRepository {
    func readData() {
        CoreDataManager.instance?.getDetailDataRx()
            .bind(to: allDetailDataRx)
            .disposed(by: disposeBag)
        
        CoreDataManager.instance?.getSimpleDataRx()
            .bind(to: allSimpleDataRx)
            .disposed(by: disposeBag)
        
        selectedDate.accept(selectedDate.value)
    }
    
    func createData(newData: DiaryModel, completion: @escaping (Bool) -> Void) {
        CoreDataManager.instance?.setData(newData: newData) { result in
            completion(result)
        }
    }
    
    func updateData(beforeData: DiaryModel, newData: DiaryModel, completion: @escaping (Bool) -> Void) {
        CoreDataManager.instance?.updateData(beforeData: beforeData, newData: newData) { result in
            completion(result)
        }
    }
    
    func deleteData(deleteData: DiaryModel, completion: @escaping (Bool) -> Void) {
        CoreDataManager.instance?.deleteData(deleteData: deleteData) { result in
            completion(result)
        }
    }
}
