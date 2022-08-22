//
//  DiaryData+CoreDataProperties.swift
//  
//
//  Created by 강조은 on 2022/08/23.
//
//

import Foundation
import CoreData


extension DiaryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryData> {
        return NSFetchRequest<DiaryData>(entityName: "DiaryData")
    }

    @NSManaged public var title: String?
    @NSManaged public var contents: String?
    @NSManaged public var date: String?

}
