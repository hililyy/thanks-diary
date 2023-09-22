//
//  SimpleDiaryData+CoreDataProperties.swift
//  
//
//  Created by 강조은 on 2022/09/05.
//
//

import Foundation
import CoreData

extension SimpleDiaryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SimpleDiaryData> {
        return NSFetchRequest<SimpleDiaryData>(entityName: "SimpleDiaryData")
    }

    @NSManaged public var contents: String?
    @NSManaged public var type: String?
    @NSManaged public var date: String?

}
