//
//  LocalDataKeySet.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import Foundation

enum LocalDataKeySet: String {
    case IS_NEW_USER = "is_new_user"
    case IS_PUSH_ALARM = "is_push_alarm"
    case IS_PASSWORD = "is_password"
    case PASSWORD_NUMBER = "password_number"
    case ALARM_TIME = "alarm_time"
    case TODAY_DETAIL_DIARY = "today_detail_diary"
    case IS_PUSH_ALARM_AGREE = "is_push_alarm_agree"
    case APPLE_LOGIN_TOKEN = "apple_login_token"
    case GOOGLE_LOGIN_TOKEN = "google_login_token"
}
