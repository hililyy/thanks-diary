//
//  Enum.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import Foundation

enum DiaryType {
    case detail
    case simple
}

enum ResponseType {
    case success
    case fail
}

enum LoginType: String {
    case none = "none"
    case email = "email"
}
