//
//  DiaryModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import Foundation
import Firebase

class DiaryModel {
    var uid: String?
    var allLong: [AllDiaryData.Long] = []
    var allShort: [AllDiaryData.Short] = []
    var diaryData = DiaryDataEntity()
    var simpleDiaryData = SimpleDiaryDataEntity()
    static var model = DiaryModel()
    
    func getFirebaseData() {
        guard let uid = uid else { return }
        allLong.removeAll()
        allShort.removeAll()
        Database.database().reference().child(uid).child("long").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let data = AllDiaryData.Long(JSON: snap.value as! [String:AnyObject]) else { return }
                self.allLong.append(data)
            }
        }
        
        Database.database().reference().child(uid).child("short").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let data = AllDiaryData.Short(JSON: snap.value as! [String:AnyObject]) else { return }
                self.allShort.append(data)
            }
        }
    }
    
    func setFirebaseData(type: DiaryType, completion: @escaping () -> ()) {
        self.uid = Auth.auth().currentUser?.uid ?? ""
        guard let uid = uid else { return }
        switch type {
        case .long :
            let longData: [String:Any] = [
                "title": diaryData.title,
                "contents": diaryData.contents,
                "date": diaryData.date
            ]
            Database.database().reference().child(uid).child("long").childByAutoId().setValue(longData)
        case .short :
            let shortData: [String:Any] = [
                "contents": simpleDiaryData.contents,
                "date": simpleDiaryData.date
            ]
            Database.database().reference().child(uid).child("short").childByAutoId().setValue(shortData)
        }
        completion()
    }
}
