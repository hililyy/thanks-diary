//
//  MainViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewModel {
    
    var allDetailData: [String: [DiaryModel]] = [:]
    var allSimpleData: [String: [DiaryModel]] = [:]
    
    var selectedDetailData: [DiaryModel] = []
    var selectedSimpleData: [DiaryModel] = []

    var selectedDate: Date = Date()
    var diaryDates: Set<String> = []
    
    // 달력에 동그라미칠 날짜 저장
    func drawCalendarCircle() {
        diaryDates = []
        
        for data in allDetailData {
            diaryDates.insert(data.key)
        }
        
        for data in allSimpleData {
            diaryDates.insert(data.key)
        }
    }
}

// 다이어리 데이터 가져오기
extension MainViewModel: DiaryReader {
    // 모든 자세한 일기 데이터 가져오기
    func getAllDiaryData(completion: @escaping () -> ()) {
        allDetailData = CoreDataManager.shared.getDetailData()
        allSimpleData = CoreDataManager.shared.getSimpleData()
        
        drawCalendarCircle()
        
        completion()
    }
    
    // 선택한 날짜에 해당하는 일기 데이터 가져오기
    func getSelectedDiaryData(completion: @escaping () -> ()) {
        let detailData = allDetailData[self.selectedDate.convertString()]
        let simpleData = allSimpleData[self.selectedDate.convertString()]
        
        selectedDetailData = detailData ?? []
        selectedSimpleData = simpleData ?? []
        
        completion()
    }
}


// 다이어리 생성, 수정, 삭제 (자세)
extension MainViewModel: DetailDiaryRepository {
    // 저장(자세)
    func setDetailData(title: String, contents: String, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.setData(
            type: .detail,
            selectedDate: selectedDate,
            title: title,
            contents: contents) { result in
                if result {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
    
    // 수정(자세)
    func updateDetailData(selectedIndex: Int, afterTitle: String, afterContents: String, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.updateData(
            type: .detail,
            selectedDate: selectedDate,
            beforeTitle: selectedDetailData[selectedIndex].title ?? "",
            beforeContents: selectedDetailData[selectedIndex].contents ?? "",
            afterTitle: afterTitle,
            afterContents: afterContents) { result in
                if result {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
    
    // 삭제(자세)
    func deleteDetailData(selectedIndex: Int, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.deleteData(
            type: .detail,
            selectedDate: selectedDate,
            title: selectedDetailData[selectedIndex].title ?? "",
            contents: selectedDetailData[selectedIndex].contents ?? "") { result in
                if result {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
}


// 다이어리 생성, 수정, 삭제 (단순)
extension MainViewModel: SimpleDiaryRepository {
    // 저장(단순)
    func setSimpleData(contents: String, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.setData(
            type: .simple,
            selectedDate: selectedDate,
            contents: contents) { result in
                if result {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
    
    // 수정(단순)
    func updateSimpleData(selectedIndex: Int, afterContents: String, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.updateData(
            type: .simple,
            selectedDate: selectedDate,
            beforeContents: selectedSimpleData[selectedIndex].contents ?? "",
            afterContents: afterContents) { result in
                if result {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
    
    // 삭제(단순)
    func deleteSimpleData(selectedIndex: Int, completion: @escaping (Bool) -> ()) {
        CoreDataManager.shared.deleteData(
            type: .simple,
            selectedDate: selectedDate,
            contents: selectedSimpleData[selectedIndex].contents ?? "") { result in
                if result {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
}
