//
//  Enum.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import Foundation

enum DiaryType: String {
    case detail
    case simple
}

enum LoginType: String {
    case none
    case email
}

enum ThemeMode: String {
    case light
    case dark
}

enum SuggestType: String {
    case waiting
    case progress
    case complete
    
    var description: String {
        switch self {
        case .waiting:
            return "대기중"
        case .progress:
            return "진행중"
        case .complete:
            return "완료"
        }
    }
}

enum SettingNameType {
    case more
    case label
    case _switch
    
}
