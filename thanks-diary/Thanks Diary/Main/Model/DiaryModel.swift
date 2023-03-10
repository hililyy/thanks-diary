//
//  DiaryModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import Foundation
import Firebase

class DiaryModel {
    var uid: String = ""
    var allLong: [AllDiaryData.Long] = []
    var allShort: [AllDiaryData.Short] = []
    static var model = DiaryModel()
    
    func getDiaryData() {
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
}
