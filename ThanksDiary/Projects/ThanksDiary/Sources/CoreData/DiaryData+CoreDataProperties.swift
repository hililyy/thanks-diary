//
//  DiaryData+CoreDataProperties.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/12/11.
//
//

import Foundation
import CoreData


extension DiaryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryData> {
        return NSFetchRequest<DiaryData>(entityName: "DiaryData")
    }

    @NSManaged public var contents: String?
    @NSManaged public var date: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?

}
