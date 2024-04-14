//
//  SimpleDiaryData+CoreDataProperties.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/12/11.
//
//

import Foundation
import CoreData


extension SimpleDiaryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SimpleDiaryData> {
        return NSFetchRequest<SimpleDiaryData>(entityName: "SimpleDiaryData")
    }

    @NSManaged public var contents: String?
    @NSManaged public var date: String?
    @NSManaged public var type: String?

}
