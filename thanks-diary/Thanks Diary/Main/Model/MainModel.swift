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
        DiaryCoreDataManager.shared.getData(loginType: loginType, selectedDate: selectedDate) {
            self.longData = DiaryCoreDataManager.shared.longData
            self.shortData = DiaryCoreDataManager.shared.shortData
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
    func getDetailFirebaseData(completion: @escaping () -> ()) {
        guard let saveUid = uid else { return }
        longDiaryData.removeAll()
        longKey.removeAll()
        dateWithCircle.removeAll()
        
        Database.database().reference().child(saveUid).child("long").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let data = AllDiaryData.Long(JSON: snap.value as! [String:AnyObject]) else { return }
                self.dateWithCircle.append(data.date ?? "")
                self.longKey.append(snap.key)
                self.longDiaryData.append(data)
            }
            completion()
        }
    }
    
    func getSimpleFirebaseData(completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        shortDiaryData.removeAll()
        shortKey.removeAll()
        
        Database.database().reference().child(uid).child("short").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let data = AllDiaryData.Short(JSON: snap.value as! [String:AnyObject]) else { return }
                self.dateWithCircle.append(data.date ?? "")
                self.shortKey.append(snap.key)
                self.shortDiaryData.append(data)
            }
            completion()
        }
    }
    
    func setFirebaseData(type: DiaryType, title: String? = nil, contents: String, date: String? = "none") {
        guard let uid = uid else { return }
        var newDate: String?
        if date == "none" {
            newDate = self.selectedDate.convertString()
        } else {
            newDate = date
        }
        switch type {
        case .detail :
            let longData: [String:Any] = [
                "title": title ?? "",
                "contents": contents,
                "date": newDate ?? ""
            ]
            Database.database().reference().child(uid).child("long").childByAutoId().setValue(longData)
        case .simple :
            let shortData: [String:Any] = [
                "contents": contents,
                "date": newDate ?? ""
            ]
            Database.database().reference().child(uid).child("short").childByAutoId().setValue(shortData)
        }
    }
    
    func updateDetailFirebaseData(selectedIndex: Int, afterTitle: String, afterContents: String, completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        let diary: [String:Any] = [
            "title": afterTitle,
            "contents": afterContents,
            "date": self.selectedDate.convertString()
        ]
        Database.database().reference().child(uid).child("long").child(longKeybyDate[selectedIndex]).updateChildValues(diary)
        completion()
    }
    
    func updateSimpleFirebaseData(selectedIndex: Int, afterContents: String, completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        let diary: [String:Any] = [
            "contents": afterContents,
            "date": self.selectedDate.convertString()
        ]
        Database.database().reference().child(uid).child("short").child(shortKeybyDate[selectedIndex]).updateChildValues(diary)
        completion()
    }
    
    func deleteDetailFirebaseData(selectedIndex: Int, completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        Database.database().reference().child(uid).child("long").child(longKeybyDate[selectedIndex]).removeValue()
        completion()
    }
    
    func deleteSimpleFirebaseData(selectedIndex: Int, completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        Database.database().reference().child(uid).child("short").child(shortKeybyDate[selectedIndex]).removeValue()
        completion()
    }
}
