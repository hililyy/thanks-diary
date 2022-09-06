//
//  DiaryData+CoreDataProperties.swift
//  
//
//  Created by 강조은 on 2022/09/05.
//
//

import Foundation
import CoreData


extension DiaryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryData> {
        return NSFetchRequest<DiaryData>(entityName: "DiaryData")
    }

    @NSManaged public var date: String?
    @NSManaged public var contents: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?

}
