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
    
    let disposeBag = DisposeBag()
    let allDetailDataRx = BehaviorRelay<[String: [DiaryEntity]]>(value: [:])
    let allSimpleDataRx = BehaviorRelay<[String: [DiaryEntity]]>(value: [:])
    
    lazy var selectedAllData: Observable<[DiaryEntity]> = selectedDate.map { date in
        let detailData = self.allDetailDataRx.value[date.toString(didChangeDateFormat: DateFormat.YYYYMD.rawValue)] ?? []
        let simpleData = self.allSimpleDataRx.value[date.toString(didChangeDateFormat: DateFormat.YYYYMD.rawValue)] ?? []
        return detailData + simpleData
    }
    
    var selectedDate = BehaviorRelay<Date>(value: Date())
    var diaryDates: Set<String> = []
    
    let simpleWriteTextmaxCount = 50
    
    var searchResultData = PublishSubject<[DiarySearchEntity]>()
    var inputText = ""
    
    init() {
        readData()
    }
}

extension MainViewModel: DiaryRepository {
    func readData() {
        CoreDataManager.instance.getDetailDataRx()
            .bind(to: allDetailDataRx)
            .disposed(by: disposeBag)
        
        CoreDataManager.instance.getSimpleDataRx()
            .bind(to: allSimpleDataRx)
            .disposed(by: disposeBag)
        
        selectedDate.accept(selectedDate.value)
    }
    
    func createData(newData: DiaryEntity) async throws {
        try await CoreDataManager.instance.setData(newData: newData)
    }
    
    func updateData(beforeData: DiaryEntity, newData: DiaryEntity) async throws {
        try await CoreDataManager.instance.updateData(beforeData: beforeData, newData: newData)
    }
    
    func deleteData(deleteData: DiaryEntity) async throws {
        try await CoreDataManager.instance.deleteData(deleteData: deleteData)
    }
}
