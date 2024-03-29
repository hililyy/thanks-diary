//
//  String.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/12.
//

import Foundation

extension String {
    func convertDate(format: String = DateFormat.YYYYMD.rawValue) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: DateFormat.TIMEZONE_IDENTIFIER.rawValue)
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    func toDate(willChangeDateFormat: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = willChangeDateFormat
        return formatter.date(from: self) ?? Date()
    }
}
