//
//  DiaryModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/23.
//

import Foundation

struct DiaryEntity: Equatable {
    var type: DiaryType
    var title: String
    var contents: String
    var date: String
}
