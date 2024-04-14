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
    case nanumBarunPen
    case harunanum
    case hagom
    case wiri
    case boksung
    case yeonyu
    case pretendard
    case kotrahope
    
    var description: String {
        switch self {
        case .nanumBarunGothic:
            return L10n.font1
            
        case .nanumBarunPen:
            return L10n.font2
            
        case .harunanum:
            return L10n.font3
            
        case .hagom:
            return L10n.font4
            
        case .wiri:
            return L10n.font5
            
        case .boksung:
            return L10n.font6
            
        case .yeonyu:
            return L10n.font7
            
        case .pretendard:
            return L10n.font8
            
        case .kotrahope:
            return L10n.font9
        }
    }
}

enum DateFormat: String {
    case HHMM = "HHmm"
    case YYYYMD = "yyyy-M-d"
    case YYMMDD = "yy/MM/dd"
    case utcFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case AHHMM = "a hh시 mm분"
    case LOCAL_IDENTIFIER = "ko_KR"
    case TIMEZONE_IDENTIFIER = "UTC"
}

enum LanguageType: Int, CaseIterable {
    case korea
    case english
    
    var description: String {
        switch self {
        case .korea:
            return "한국어"
        case .english:
            return "English"
        }
    }
    
    var key: String {
        switch self {
        case .korea:
            return "korea"
        case .english:
            return "english"
        }
    }
}
