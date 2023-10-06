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
    var allDetailDataRx = BehaviorRelay<[String: [DiaryModel]]>(value: [:])
    var allSimpleDataRx = BehaviorRelay<[String: [DiaryModel]]>(value: [:])

    lazy var selectedAllData: Observable<[DiaryModel]> = selectedDate.map { date in
        let detailData = self.allDetailDataRx.value[date.convertString()] ?? []
        let simpleData = self.allSimpleDataRx.value[date.convertString()] ?? []
        return detailData + simpleData
    }
    
    var selectedDate = BehaviorRelay<Date>(value: Date())
    var diaryDates: Set<String> = []
    
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
        CoreDataManager.instance?.setData(newData: newData) { [weak self] result in
            guard let self else { return }
            completion(result)
        }
    }
    
    func updateData(beforeData: DiaryModel, newData: DiaryModel, completion: @escaping (Bool) -> Void) {
        CoreDataManager.instance?.updateData(beforeData: beforeData, newData: newData) { [weak self] result in
            guard let self else { return }
            completion(result)
        }
    }
    
    func deleteData(deleteData: DiaryModel, completion: @escaping (Bool) -> Void) {
        CoreDataManager.instance?.deleteData(deleteData: deleteData) { [weak self] result in
            guard let self else { return }
            completion(result)
        }
    }
}
