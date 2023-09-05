//
//  SettingSuggestModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import Foundation

struct SettingSuggestModel: Codable {
    var uid: String
    var contents: String
    var status: String
    
    init(uid:String,contents:String,status:String) {
        self.uid = uid
        self.contents = contents
        self.status = status
    }
}
