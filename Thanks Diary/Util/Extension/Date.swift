//
//  Date.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/12.
//

import Foundation

extension Date {
    func toString(didChangeDateFormat: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = didChangeDateFormat
        return formatter.string(from: self)
    }
}
