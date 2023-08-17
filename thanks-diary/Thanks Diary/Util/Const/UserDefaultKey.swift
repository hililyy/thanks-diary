//
//  UserDefaultKey.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import UIKit

struct UserDefaultKey {
    
    private init() {}
    
    static let IS_LOGIN = "IS_LOGIN" // 로그인 여부
    static let PASSWORD = "PASSWORD" // 비밀번호
    static let IS_PASSWORD = "IS_PASSWORD" // 비밀번호 여부
    static let PUSH_TIME = "PUSH_TIME" // 설정한 푸시 시간
    static let IS_PUSH = "IS_PUSH" // 푸시 여부
    static let THEME_MODE = "THEME_MODE" // 앱 테마 (라이트, 다크)
}
