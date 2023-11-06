//
//  DiaryProtocol.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/13.
//

import Foundation

protocol DiaryRepository {
    func readData()
    func createData(newData: DiaryModel) async throws
    func updateData(beforeData: DiaryModel, newData: DiaryModel) async throws
    func deleteData(deleteData: DiaryModel) async throws
}
