//
//  String.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/12.
//

import Foundation

extension String {
    func convertDate(format: String = "yyyy-M-d") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}
