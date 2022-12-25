//
//  EmailLoginErrorList.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/26.
//

import Foundation

enum EmailErrorList: NSInteger {
    case ALREADY_SIGNUP = 17007
    case WRONG_EMAIL_FORMAT = 17008
    case MISMATCH_PASSWORD = 17009
    case NON_EXISTENT_USER = 17011
    case SHORT_PASSWORD = 17026
}
