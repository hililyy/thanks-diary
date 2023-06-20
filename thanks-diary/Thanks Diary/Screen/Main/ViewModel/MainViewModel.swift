//
//  MainViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/20.
//

import Foundation

final class MainViewModel {
    
    var detailData: [DiaryEntity] = []
    var simpleData: [SimpleDiaryEntity] = []
    
    var dateWithCircle: [String] = []
    var selectedDate: Date = Date()
    
    var detailDiaryData: [AllDiaryData.Detail] = []
    var simpleDiaryData: [AllDiaryData.Simple] = []
    var detailDiaryDatabyDate: [AllDiaryData.Detail] = []
    var simpleDiaryDatabyDate: [AllDiaryData.Simple] = []
    var detailKey: [String] = []
    var simpleKey: [String] = []
    var detailKeybyDate: [String] = []
    var simpleKeybyDate: [String] = []
    var loginType: LoginType = .none
    
    func getData(completion: @escaping () -> ()) {
        DiaryCoreDataManager.shared.getData(
            loginType: loginType,
            selectedDate: selectedDate) {
                completion()
            }
    }
    
    func setData(diaryType: DiaryType, title: String = "", contents: String) {
        DiaryCoreDataManager.shared.setData(
            type: diaryType,
            selectedDate: selectedDate,
            title: title, contents: contents
        )
    }
    
    func updateData(diaryType: DiaryType, selectedIndex: Int, afterTitle: String = "", afterContents: String) {
        DiaryCoreDataManager.shared.updateData(
            type: diaryType,
            selectedDate: selectedDate,
            selectedIndex: selectedIndex,
            afterTitle: afterTitle,
            afterContents: afterContents
        )
    }
    
    func deleteData(diaryType: DiaryType, selectedIndex: Int) {
        DiaryCoreDataManager.shared.deleteData(
            type: diaryType,
            selectedDate: selectedDate,
            selectedIndex: selectedIndex
        )
    }
    
    // MARK: Firebase Code
    
    func getFirebaseData(completion: @escaping () -> ()) {
        DiaryFirebaseManager.shared.getData {
            completion()
        }
    }
    
    func setFirebaseData(diaryType: DiaryType, title: String = "", contents: String, date: String = "") {
        var newDate: String?
        if date == "" {
            newDate = self.selectedDate.convertString()
        } else {
            newDate = date
        }
        DiaryFirebaseManager.shared.setData(
            type: diaryType,
            title: title,
            contents: contents,
            date: newDate ?? ""
        )
    }
    
    func updateFirebaseData(diaryType: DiaryType, selectedIndex: Int, afterTitle: String = "", afterContents: String, completion: @escaping () -> ()) {
        DiaryFirebaseManager.shared.updateData(
            diaryType: diaryType,
            selectedDate: selectedDate,
            selectedIndex: selectedIndex,
            afterTitle: afterTitle,
            afterContents: afterContents) {
                completion()
            }
    }
    
    func deleteFirebaseData(diaryType: DiaryType, selectedIndex: Int, completion: @escaping () -> ()) {
        DiaryFirebaseManager.shared.deleteData(
            diaryType: diaryType,
            selectedIndex: selectedIndex) {
                completion()
            }
    }
    
    func uploadData() {
        self.getData() {
            for data in self.detailData {
                self.setFirebaseData(
                    diaryType: .detail,
                    title: data.title ?? "",
                    contents: data.contents ?? "",
                    date: data.date ?? "")
            }
            for data in self.simpleData {
                self.setFirebaseData(
                    diaryType: .simple,
                    contents: data.contents ?? "",
                    date: data.date ?? "")
            }
        }
    }
    
    func setDataByDate() {
        detailDiaryDatabyDate.removeAll()
        simpleDiaryDatabyDate.removeAll()
        detailKeybyDate.removeAll()
        simpleKeybyDate.removeAll()
        var count = 0
        for diary in detailDiaryData {
            if selectedDate.convertString() == diary.date {
                detailDiaryDatabyDate.append(diary)
                detailKeybyDate.append(detailKey[count])
            }
            count+=1
        }
        count = 0
        for diary in simpleDiaryData {
            if selectedDate.convertString() == diary.date {
                simpleDiaryDatabyDate.append(diary)
                simpleKeybyDate.append(simpleKey[count])
            }
            count+=1
        }
    }
}
