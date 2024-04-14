//
//  SettingSuggestModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import Foundation

struct SettingSuggestModel {
    var postId: String
    var contents: String
    var status: String
    var createDate: String
    var likeCount: Int
    var replys: [SettingSuggestReplyModel] = []
}

struct SettingSuggestReplyModel {
    var parentId: String
    var contents: String
    var createDate: String
}

extension SettingSuggestModel {
    static func initData() -> SettingSuggestModel {
        return SettingSuggestModel(postId: "",
                                   contents: "",
                                   status: "",
                                   createDate: "",
                                   likeCount: 0)
    }
}

extension SettingSuggestReplyModel {
    static func initReplyData() -> SettingSuggestReplyModel {
        return SettingSuggestReplyModel(parentId: "",
                                        contents: "",
                                        createDate: "")
    }
}
