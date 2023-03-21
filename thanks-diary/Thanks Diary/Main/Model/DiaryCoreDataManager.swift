//
//  DiaryCoreDataManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/21.
//

import UIKit
import CoreData

final class DiaryCoreDataManager {

    static let shared = DiaryCoreDataManager()
    
    func getData(loginType: LoginType, selectedDate: Date, completion: @escaping () -> ()) {
        MainModel.model.longData.removeAll()
        MainModel.model.shortData.removeAll()
        MainModel.model.dateWithCircle.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let datailFetch = NSFetchRequest<NSManagedObject>(entityName: "DiaryData")
        let simpleFetch = NSFetchRequest<NSManagedObject>(entityName: "SimpleDiaryData")
        do {
            let datailResult = try managedContext.fetch(datailFetch)
            for data in datailResult {
                guard let type = data.value(forKey: "type") as? String,
                      let title = data.value(forKey: "title") as? String,
                      let contents = data.value(forKey: "contents") as? String,
                      let date = data.value(forKey: "date") as? String
                else { return }
                
                if loginType == .none {
                    MainModel.model.dateWithCircle.append(date)
                    if date == selectedDate.convertString() {
                        addArray(type: .detail, title: title, contents: contents, date: date)
                    }
                } else {
                    addArray(type: .detail, title: title, contents: contents, date: date)
                }
            }
            let simpleResult = try managedContext.fetch(simpleFetch)
            for data in simpleResult {
                guard let type = data.value(forKey: "type") as? String,
                      let contents = data.value(forKey: "contents") as? String,
                      let date = data.value(forKey: "date") as? String
                else { return }
                if loginType == .none {
                    MainModel.model.dateWithCircle.append(date)
                    if date == selectedDate.convertString() {
                        addArray(type: .simple, contents: contents, date: date)
                    }
                } else {
                    addArray(type: .simple, contents: contents, date: date)
                }
            }
            completion()
        } catch let error as NSError {
            print(ErrorCase.NOT_SAVE_DATA)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func addArray(type: DiaryType, title: String = "", contents: String, date: String) {
        switch type {
        case .detail:
            let longEntity = DiaryEntity(
                type: "detail",
                title: title,
                contents: contents,
                date: date
            )
            MainModel.model.longData.append(longEntity)
        case .simple:
            let shortEntity = SimpleDiaryEntity(
                type: "simple",
                contents: contents,
                date: date
            )
            MainModel.model.shortData.append(shortEntity)
        }
    }
    
    func setData(type: DiaryType, selectedDate: Date, title: String, contents: String) {
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
                    return
                } catch {
                    print(ErrorCase.NOT_SAVE_DATA)
                    return
                }
            } else { return }
        case .simple:
            let entity = NSEntityDescription.entity(forEntityName: "SimpleDiaryData", in: context)
            if let entity = entity {
                let managedObject = NSManagedObject(entity: entity, insertInto: context)
                managedObject.setValue(contents, forKey: "contents")
                managedObject.setValue(selectedDate.convertString(), forKey: "date")
                managedObject.setValue("simple", forKey: "type")
                do {
                    try context.save()
                    return
                } catch {
                    print(ErrorCase.NOT_SAVE_DATA)
                    return
                }
            } else { return }
        }
    }
    
    func updateData(type: DiaryType, selectedDate: Date, selectedIndex: Int, afterTitle: String, afterContents: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        switch type {
        case .detail:
            guard let title = MainModel.model.longData[selectedIndex].title,
                  let contents = MainModel.model.longData[selectedIndex].contents else { return }
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && title = %@ && contents = %@", selectedDate.convertString(), title, contents)
            do {
                let result = try managedContext.fetch(fetchRequest)
                let objectUpdate = result[0] as! NSManagedObject
                objectUpdate.setValue(afterTitle, forKey: "title")
                objectUpdate.setValue(afterContents, forKey: "contents")
                do {
                    try managedContext.save()
                } catch {
                    print(ErrorCase.NOT_SAVE_DATA)
                    print(error)
                }
            } catch {
                print(ErrorCase.NOT_SAVE_DATA)
                print(error)
            }
        case .simple:
            guard let contents = MainModel.model.shortData[selectedIndex].contents else { return }
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "SimpleDiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && contents = %@", selectedDate.convertString(), contents)
            do {
                let result = try managedContext.fetch(fetchRequest)
                let objectUpdate = result[0] as! NSManagedObject
                objectUpdate.setValue(afterContents, forKey: "contents")
                do {
                    try managedContext.save()
                } catch {
                    print(ErrorCase.NOT_SAVE_DATA)
                    print(error)
                }
            } catch {
                print(ErrorCase.NOT_SAVE_DATA)
                print(error)
            }
        }
    }
    
    func deleteData(type: DiaryType, selectedDate: Date, selectedIndex: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        switch type {
        case .detail:
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                  let title = MainModel.model.longData[selectedIndex].title,
                  let contents = MainModel.model.longData[selectedIndex].contents
            else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && title = %@ && contents = %@", selectedDate.convertString(), title, contents)
            do {
                let test = try managedContext.fetch(fetchRequest)
                let objectToDelete = test[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
                do {
                    try managedContext.save()
                } catch {
                    print(ErrorCase.NOT_SAVE_DATA)
                    print(error)
                }
            } catch {
                print(ErrorCase.NOT_SAVE_DATA)
                print(error)
            }
        case .simple:
            guard let contents = MainModel.model.shortData[selectedIndex].contents else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "SimpleDiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && contents = %@", selectedDate.convertString(), contents)
            do {
                let test = try managedContext.fetch(fetchRequest)
                let objectToDelete = test[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
                do {
                    try managedContext.save()
                } catch {
                    print(ErrorCase.NOT_SAVE_DATA)
                    print(error)
                }
            } catch {
                print(ErrorCase.NOT_SAVE_DATA)
                print(error)
            }
        }
    }
    
    func deleteAllData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DiaryData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "SimpleDiaryData")
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        do {
            try managedContext.execute(deleteRequest2)
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
}
