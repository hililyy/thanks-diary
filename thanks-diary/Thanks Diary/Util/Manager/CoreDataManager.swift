//
//  CoreDataManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() { }
    
    func getDetailData() -> [String: [DiaryEntity]] {
        var detailData: [String: [DiaryEntity]] = [:]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [:] }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DiaryData")
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            for data in result {
                let diary = DiaryEntity(
                    type: data.value(forKey: "type") as? String,
                    title: data.value(forKey: "title") as? String,
                    contents: data.value(forKey: "contents") as? String,
                    date: data.value(forKey: "date") as? String
                )
                
                guard let date = diary.date else { return [:] }
                
                if detailData[date] == nil {
                    detailData[date] = []
                }
                
                detailData[date]?.append(diary)
            }
        } catch let error as NSError {
            print(ErrorCase.NOT_SAVE_DATA)
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return detailData
    }
    
    func getSimpleData() -> [String: [SimpleDiaryEntity]] {
        var simpleData: [String: [SimpleDiaryEntity]] = [:]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [:] }
            let managedContext = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SimpleDiaryData")
        do {
            let result = try managedContext.fetch(fetchRequest)

            for data in result {
                let diary = SimpleDiaryEntity(
                    type: data.value(forKey: "type") as? String,
                    contents: data.value(forKey: "contents") as? String,
                    date: data.value(forKey: "date") as? String
                )
                
                guard let date = diary.date else { return [:] }
                
                if simpleData[date] == nil {
                    simpleData[date] = []
                }
                
                simpleData[date]?.append(diary)
            }
        } catch let error as NSError {
            print(ErrorCase.NOT_SAVE_DATA)
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return simpleData
    }
    
    func setData(type: DiaryType, selectedDate: Date, title: String = "", contents: String, completion: @escaping (Bool) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        switch type {
            
        case .detail:
            let entity = NSEntityDescription.entity(forEntityName: "DiaryData", in: context)
            if let entity = entity {
                let managedObject = NSManagedObject(entity: entity, insertInto: context)
                managedObject.setValue(title, forKey: "title")
                managedObject.setValue(contents, forKey: "contents")
                managedObject.setValue(selectedDate.convertString(), forKey: "date")
                managedObject.setValue("detail", forKey: "type")
                do {
                    try context.save()
                    completion(true)
                    return
                } catch {
                    print(ErrorCase.NOT_SAVE_DATA)
                    completion(false)
                    return
                }
            } else {
                completion(false)
                return
            }
            
        case .simple:
            let entity = NSEntityDescription.entity(forEntityName: "SimpleDiaryData", in: context)
            if let entity = entity {
                let managedObject = NSManagedObject(entity: entity, insertInto: context)
                managedObject.setValue(contents, forKey: "contents")
                managedObject.setValue(selectedDate.convertString(), forKey: "date")
                managedObject.setValue("simple", forKey: "type")
                do {
                    try context.save()
                    completion(true)
                    return
                } catch {
                    print(ErrorCase.NOT_SAVE_DATA)
                    completion(false)
                    return
                }
            } else {
                completion(false)
                return
            }
        }
    }
    
    func updateData(type: DiaryType, selectedDate: Date, beforeTitle: String = "", beforeContents: String, afterTitle: String = "", afterContents: String, completion: @escaping (Bool) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        switch type {
            
        case .detail:
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && title = %@ && contents = %@", selectedDate.convertString(), beforeTitle, beforeContents)
            do {
                let result = try managedContext.fetch(fetchRequest)
                let objectUpdate = result[0] as! NSManagedObject
                objectUpdate.setValue(afterTitle, forKey: "title")
                objectUpdate.setValue(afterContents, forKey: "contents")
                do {
                    try managedContext.save()
                    completion(true)
                } catch {
                    completion(false)
                }
            } catch {
                completion(false)
            }
            
        case .simple:
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "SimpleDiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && contents = %@", selectedDate.convertString(), beforeContents)
            do {
                let result = try managedContext.fetch(fetchRequest)
                let objectUpdate = result[0] as! NSManagedObject
                objectUpdate.setValue(afterContents, forKey: "contents")
                do {
                    try managedContext.save()
                    completion(true)
                } catch {
                    print(ErrorCase.NOT_SAVE_DATA)
                    print(error)
                    completion(false)
                }
            } catch {
                print(ErrorCase.NOT_SAVE_DATA)
                print(error)
                completion(false)
            }
        }
    }
    
    func deleteData(type: DiaryType, selectedDate: Date, title: String = "", contents: String, completion: @escaping (Bool) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        switch type {
        case .detail:
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && title = %@ && contents = %@", selectedDate.convertString(), title, contents)
            do {
                let test = try managedContext.fetch(fetchRequest)
                let objectToDelete = test[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
                do {
                    try managedContext.save()
                    completion(true)
                } catch {
                    print(ErrorCase.NOT_SAVE_DATA)
                    print(error)
                    completion(false)
                }
            } catch {
                print(ErrorCase.NOT_SAVE_DATA)
                print(error)
                completion(false)
            }
        case .simple:
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "SimpleDiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && contents = %@", selectedDate.convertString(), contents)
            do {
                let test = try managedContext.fetch(fetchRequest)
                let objectToDelete = test[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
                do {
                    try managedContext.save()
                    completion(true)
                } catch {
                    print(ErrorCase.NOT_SAVE_DATA)
                    print(error)
                    completion(false)
                }
            } catch {
                print(ErrorCase.NOT_SAVE_DATA)
                print(error)
                completion(false)
            }
        }
    }
}
