//
//  DiaryProtocol.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/13.
//

import Foundation

protocol DetailDiaryRepository {
    func setDetailData(title: String, contents: String, completion: @escaping (Bool) -> ())
    func updateDetailData(selectedIndex: Int, afterTitle: String, afterContents: String, completion: @escaping (Bool) -> ())
    func deleteDetailData(selectedIndex: Int, completion: @escaping (Bool) -> ())
    
}

protocol SimpleDiaryRepository {
    func setSimpleData(contents: String, completion: @escaping (Bool) -> ())
    func updateSimpleData(selectedIndex: Int, afterContents: String, completion: @escaping (Bool) -> ())
    func deleteSimpleData(selectedIndex: Int, completion: @escaping (Bool) -> ())
}

protocol DiaryReader {
    func getAllDiaryData(completion: @escaping () -> ())
    func getSelectedDiaryData(completion: @escaping () -> ())
}

protocol reloadDelegate {
    func reloadData()
}
