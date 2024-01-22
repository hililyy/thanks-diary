//
//  DiaryProtocol.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/13.
//

import Foundation

protocol DiaryRepository {
    func readData()
    func createData(newData: DiaryEntity) async throws
    func updateData(beforeData: DiaryEntity, newData: DiaryEntity) async throws
    func deleteData(deleteData: DiaryEntity) async throws
}
