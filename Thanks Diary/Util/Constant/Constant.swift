//
//  Constant.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/25.
//

import Foundation

final class Constant {
    
    private init() {}
    
    static let EMAIL = "joun406@gmail.com"
    static let INIT_PASSWORD = "0000"
    
    // Firebase
    static let FIREBASE_CHILD_SUGGEST = "suggest"
    
    static let FIREBASE_ITEM_CONTENTS = "contents"
    static let FIREBASE_ITEM_CREATEDATE = "createDate"
    static let FIREBASE_LIKE_COUNT = "likeCount"
    static let FIREBASE_POST_ID = "postId"
    static let FIREBASE_ITEM_STATUS = "status"
    
    // info.plist
    static let INFO_APP_VERSION = "CFBundleShortVersionString"
    
    // push
    static let PUSH_IDENTIFIER = "LOCAL_PUSH"
    
    // date
    static let HHMM = "HHmm"
    static let YYYYMD = "yyyy-M-d"
    static let YYMMDD = "yy/MM/dd"
    static let utcFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    static let AHHMM = "a hh시 mm분"
    static let LOCAL_IDENTIFIER = "ko_KR"
    static let TIMEZONE_IDENTIFIER = "UTC"
}
