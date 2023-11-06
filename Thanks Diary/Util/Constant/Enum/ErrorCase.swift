//
//  ErrorCase.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/10/20.
//

import Foundation

enum ErrorCase: Error {
    case NOT_REQUEST_DATA
    case NOT_SAVE_DATA
    case NOT_READ_DATA
    case NOT_UPDATE_DATA
    case NOT_DELETE_DATA
    case NOT_EXIST_INDEX
    case EMPTY_CONTENTS
    case ERROR_NETWORK
    case AUTHENTICATION
    case APP_UPDATE_REQUIRED
    case ETC_ERROR
}
