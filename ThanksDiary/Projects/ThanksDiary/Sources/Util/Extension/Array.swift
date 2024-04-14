//
//  Array.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/04.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
