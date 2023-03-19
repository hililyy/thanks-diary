//
//  PLoginViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/20.
//

import Foundation

protocol PLoginViewModel {
    func success(type: LoginType)
    func fail(type: LoginType, errorMessage: String)
}
