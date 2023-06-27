//
//  MainViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit
import Foundation
import CoreData

class MainViewModel {
    
    var allDetailData: [String: [DiaryEntity]] = [:]
    var allSimpleData: [String: [SimpleDiaryEntity]] = [:]
    
    var selectedDetailData: [DiaryEntity] = []
    var selectedSimpleData: [SimpleDiaryEntity] = []
    var longDiaryFlag: Bool = false
    var selectedDate: Date = Date()
    var dateList: [String] = []
    var diaryDates: Set<String> = []
    
    // 모든 자세한 일기 데이터 가져오기
    func getAllDiaryData(completion: @escaping () -> ()) {
        allDetailData = CoreDataManager.shared.getDetailData()
        allSimpleData = CoreDataManager.shared.getSimpleData()
        
        drawCalendarCircle()
        
        completion()
    }
    
    // 선택한 날짜에 해당하는 자세한 일기 데이터 가져오기
    func getSelectedDiaryData(completion: @escaping () -> ()) {
        let detailData = allDetailData[self.selectedDate.convertString()]
        let simpleData = allSimpleData[self.selectedDate.convertString()]
        
        selectedDetailData = detailData ?? []
        selectedSimpleData = simpleData ?? []
        
        completion()
    }
    
    func drawCalendarCircle() {
        // 달력에 동그라미칠 날짜 저장
        for data in allDetailData {
            diaryDates.insert(data.key)
        }
        
        for data in allSimpleData {
            diaryDates.insert(data.key)
        }
    }
    
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
