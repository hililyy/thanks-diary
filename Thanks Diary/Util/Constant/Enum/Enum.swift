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
            return L10n.waiting
        case .progress:
            return L10n.progress
        case .complete:
            return L10n.complete
        }
    }
}

enum SettingNameType {
    case more
    case label
    case _switch
}

enum PositionType {
    case top
    case center
    case bottom
}
