//
//  DiaryProtocol.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/13.
//

import Foundation

protocol DiaryRepository {
    func getData()
    func setData(newData: DiaryModel, completion: @escaping (Bool) -> ())
    func updateData(beforeData: DiaryModel, newData: DiaryModel, completion: @escaping (Bool) -> ())
    func deleteData(deleteData: DiaryModel, completion: @escaping (Bool) -> ())
}

protocol reloadDelegate {
    func reloadData()
}
