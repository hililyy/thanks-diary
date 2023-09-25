//
//  Date.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/12.
//

import Foundation
extension Date {
    func convertString(format: String = Constant.YYYYMD) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: Constant.LOCAL_IDENTIFIER)
        return dateFormatter.string(from: self)
    }
}
