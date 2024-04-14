//
//  CellIdentifier.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/06.
//

import Foundation

protocol CellIdentifier: AnyObject {
    static var id: String { get }
}

extension CellIdentifier {
    static var id: String {
        String(describing: self)
    }
}
