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

enum FontType: Int, CaseIterable {
    case nanumBarunGothic
    case harunanum
    case uniLab
    case wiri
    case pretendard
    case scoreDream
    case kotrahope
    case kotraGothic
    
    var description: String {
        switch self {
        case .nanumBarunGothic:
            return "나눔바른고딕"
        case .harunanum:
            return "온글잎 하루나눔"
        case .uniLab:
            return "온글잎 안될과학유니랩장체"
        case .wiri:
            return "온글잎 위리체"
        case .pretendard:
            return "프리텐다드"
        case .scoreDream:
            return "에스코어드림"
        case .kotrahope:
            return "코트라 희망체"
        case .kotraGothic:
            return "코트라 고딕체"
        }
    }
}
