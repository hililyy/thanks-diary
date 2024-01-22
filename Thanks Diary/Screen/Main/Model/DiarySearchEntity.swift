//
//  DiarySearchEntity.swift
//  Thanks Diary
//
//  Created by 강조은 on 2024/01/19.
//

import Foundation

struct DiarySearchEntity: Equatable {
    var type: DiaryType
    var title: String
    var contents: String
    var date: String
    var correctType: SearchCorrectType
}

enum SearchCorrectType {
    case title
    case contents
}
