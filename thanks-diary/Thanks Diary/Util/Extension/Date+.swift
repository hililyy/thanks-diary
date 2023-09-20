//
//  Date.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/12.
//

import Foundation

extension Date {
    
    func convertString(format: String = "yyyy-M-d") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
}
