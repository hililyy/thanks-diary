//
//  DiaryProtocol.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/13.
//

import Foundation

protocol DiaryRepository {
    func readData()
    func createData(newData: DiaryModel, completion: @escaping (Bool) -> Void)
    func updateData(beforeData: DiaryModel, newData: DiaryModel, completion: @escaping (Bool) -> Void)
    func deleteData(deleteData: DiaryModel, completion: @escaping (Bool) -> Void)
}
