//
//  String.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/12.
//

import Foundation

extension String {
    func convertDate(format: String = Constant.YYYYMD) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: Constant.TIMEZONE_IDENTIFIER)
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
