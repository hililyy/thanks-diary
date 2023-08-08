//
//  CommonUtilManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/08.
//

import Foundation

class CommonUtilManager {
    
    static let shared = CommonUtilManager()
    private init() { }
    
    func getAppVersion() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "앱 버전 정보를 찾을 수 없습니다."
        }
        return version
    }
}
