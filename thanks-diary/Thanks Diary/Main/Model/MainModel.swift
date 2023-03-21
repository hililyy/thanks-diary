//
//  MainModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/23.
//

import UIKit
import Firebase

final class MainModel {
    static let model = MainModel()
    var longData: [DiaryEntity] = []
    var shortData: [SimpleDiaryEntity] = []
    
    var dateWithCircle: [String] = []
    var selectedDate: Date = Date()
    
    var uid: String?
    var longDiaryData: [AllDiaryData.Long] = []
    var shortDiaryData: [AllDiaryData.Short] = []
    var longDiaryDatabyDate: [AllDiaryData.Long] = []
    var shortDiaryDatabyDate: [AllDiaryData.Short] = []
    var longKey: [String] = []
    var shortKey: [String] = []
    var longKeybyDate: [String] = []
    var shortKeybyDate: [String] = []
    var loginType: LoginType?
    
    
    func getData(completion: @escaping () -> ()) {
        guard let loginType = loginType else { return }
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
}
