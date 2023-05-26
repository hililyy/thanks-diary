//
//  DiaryFirebaseManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/21.
//

import UIKit
import Firebase

final class DiaryFirebaseManager {
    var uid: String?
    var loginType: LoginType?
    static let shared = DiaryFirebaseManager()
    
    private init() {
        self.uid = Auth.auth().currentUser?.uid
//        self.loginType = LoginType(rawValue: LocalDataStore.localDataStore.getLoginType()!)
    }
    
    func getData(completion: @escaping () -> ()) {
        MainModel.model.detailDiaryData.removeAll()
        MainModel.model.simpleDiaryData.removeAll()
        MainModel.model.detailKey.removeAll()
        MainModel.model.simpleKey.removeAll()
        MainModel.model.dateWithCircle.removeAll()
        guard let uid = uid else { return }
        
        Database.database().reference().child(uid).child("detail").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let data = AllDiaryData.Detail(JSON: snap.value as! [String:AnyObject]) else { return }
                MainModel.model.dateWithCircle.append(data.date ?? "")
                MainModel.model.detailKey.append(snap.key)
                MainModel.model.detailDiaryData.append(data)
            }
        }
        
        Database.database().reference().child(uid).child("simple").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let data = AllDiaryData.Simple(JSON: snap.value as! [String:AnyObject]) else { return }
                MainModel.model.dateWithCircle.append(data.date ?? "")
                MainModel.model.simpleKey.append(snap.key)
                MainModel.model.simpleDiaryData.append(data)
            }
            completion()
        }
    }
    
    func setData(type: DiaryType, title: String, contents: String, date: String) {
        guard let uid = uid else { return }

        switch type {
        case .detail :
            let detailData: [String:Any] = [
                "title": title,
                "contents": contents,
                "date": date
            ]
            Database.database().reference().child(uid).child("detail").childByAutoId().setValue(detailData)
        case .simple :
            let simpleData: [String:Any] = [
                "contents": contents,
                "date": date
            ]
            Database.database().reference().child(uid).child("simple").childByAutoId().setValue(simpleData)
        }
    }
    
    func updateData(diaryType: DiaryType, selectedDate: Date, selectedIndex: Int, afterTitle: String, afterContents: String, completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        
        switch diaryType {
        case .detail:
            let diary: [String:Any] = [
                "title": afterTitle,
                "contents": afterContents,
                "date": selectedDate.convertString()
            ]
            Database.database().reference().child(uid).child("detail").child(MainModel.model.detailKeybyDate[selectedIndex]).updateChildValues(diary)
            completion()
        case .simple:
            let diary: [String:Any] = [
                "contents": afterContents,
                "date": selectedDate.convertString()
            ]
            Database.database().reference().child(uid).child("simple").child(MainModel.model.simpleKeybyDate[selectedIndex]).updateChildValues(diary)
            completion()
        }
    }
    
    func deleteData(diaryType: DiaryType, selectedIndex: Int, completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        
        switch diaryType {
        case .detail:
            Database.database().reference().child(uid).child("detail").child(MainModel.model.detailKeybyDate[selectedIndex]).removeValue()
            completion()
        case .simple:
            Database.database().reference().child(uid).child("simple").child(MainModel.model.simpleKeybyDate[selectedIndex]).removeValue()
            completion()
        }
    }
}
