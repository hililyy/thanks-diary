//
//  PLoginModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/20.
//

import Foundation

protocol PLoginValidity {
    func success()
    func fail(errorMessage: String)
}
