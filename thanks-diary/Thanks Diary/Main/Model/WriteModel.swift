//
//  WriteModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import Foundation
import Firebase

class WriteModel {
    static var writeModel = WriteModel()
    var uid: String = ""
    var diaryData = DiaryDataEntity()
    var simpleDiaryData = SimpleDiaryDataEntity()
    
    func setDiaryData(type: DiaryType, completion: @escaping () -> ()) {
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
