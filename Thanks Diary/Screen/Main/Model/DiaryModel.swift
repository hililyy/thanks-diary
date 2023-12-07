//
//  DiaryModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/23.
//

import Foundation

struct DiaryModel: Equatable {
    var type: DiaryType
    var title: String
    var contents: String
    var date: String
}

struct DiarySearchModel: Equatable {
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
