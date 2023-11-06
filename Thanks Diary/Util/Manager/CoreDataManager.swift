//
//  CoreDataManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit
import CoreData
import RxSwift

final class CoreDataManager {
    
    private init() {}
    
    private static let _instance = CoreDataManager()
    
    static var instance: CoreDataManager {
        return _instance
    }
    
    func getDetailDataRx() -> Observable<[String: [DiaryModel]]> {
        return Observable.create { emitter in
            let result = self.getDetailData()
            if let result {
                emitter.onNext(result)
                emitter.onCompleted()
            } else {
                emitter.onError(ErrorCase.NOT_REQUEST_DATA)
            }
            
            return Disposables.create()
        }
    }
    
    func getDetailData() -> [String: [DiaryModel]]? {
        var detailData: [String: [DiaryModel]] = [:]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [:] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DiaryData")
        
        do {
            let result = try context.fetch(fetchRequest)
            
            for data in result {
                guard let type = DiaryType(rawValue: data.value(forKey: "type") as? String ?? ""),
                      let title = data.value(forKey: "title") as? String,
                      let contents = data.value(forKey: "contents") as? String,
                      let date = data.value(forKey: "date") as? String else { return [:] }
                
                let diary = DiaryModel(
                    type: type,
                    title: title,
                    contents: contents,
                    date: date
                )
                
                if detailData[date] == nil {
                    detailData[date] = []
                }
                
                detailData[date]?.append(diary)
            }
            return detailData
            
        } catch {
            print(ErrorCase.NOT_SAVE_DATA)
            return nil
        }
    }
    
    func getSimpleDataRx() -> Observable<[String: [DiaryModel]]> {
        return Observable.create { emitter in
            let result = self.getSimpleData()
            if let result {
                emitter.onNext(result)
                emitter.onCompleted()
            } else {
                emitter.onError(ErrorCase.NOT_REQUEST_DATA)
            }
            
            return Disposables.create()
        }
    }
    
    func getSimpleData() -> [String: [DiaryModel]]? {
        var simpleData: [String: [DiaryModel]] = [:]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [:] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SimpleDiaryData")
        
        do {
            let result = try context.fetch(fetchRequest)
            
            for data in result {
                guard let type = DiaryType(rawValue: data.value(forKey: "type") as? String ?? ""),
                      let contents = data.value(forKey: "contents") as? String,
                      let date = data.value(forKey: "date") as? String else { return [:] }
                
                let diary = DiaryModel(
                    type: type,
                    title: "",
                    contents: contents,
                    date: date
                )
                
                if simpleData[date] == nil {
                    simpleData[date] = []
                }
                
                simpleData[date]?.append(diary)
            }
            return simpleData
            
        } catch let error as NSError {
            print(ErrorCase.NOT_SAVE_DATA)
            print("Could not save. \(error), \(error.userInfo)")
            
            return nil
        }
    }
    
    func setData(newData: DiaryModel) async throws {
        guard let appDelegate = await UIApplication.shared.delegate as? AppDelegate else { throw ErrorCase.NOT_SAVE_DATA }
        let context = await appDelegate.persistentContainer.viewContext
        
        switch newData.type {
            
        case .detail:
            let entity = NSEntityDescription.entity(forEntityName: "DiaryData", in: context)
            
            guard let entity else { throw ErrorCase.NOT_SAVE_DATA }
            
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(newData.title, forKey: "title")
            managedObject.setValue(newData.contents, forKey: "contents")
            managedObject.setValue(newData.date, forKey: "date")
            managedObject.setValue("detail", forKey: "type")
            
            do {
                try context.save()
            } catch {
                throw ErrorCase.NOT_SAVE_DATA
            }
            
        case .simple:
            let entity = NSEntityDescription.entity(forEntityName: "SimpleDiaryData", in: context)
            
            guard let entity else { return }
            
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(newData.contents, forKey: "contents")
            managedObject.setValue(newData.date, forKey: "date")
            managedObject.setValue("simple", forKey: "type")
            
            do {
                try context.save()
            } catch {
                throw ErrorCase.NOT_SAVE_DATA
            }
        }
    }
    
    func updateData(beforeData: DiaryModel, newData: DiaryModel) async throws {
        guard let appDelegate = await UIApplication.shared.delegate as? AppDelegate else { throw ErrorCase.NOT_UPDATE_DATA }
        let context = await appDelegate.persistentContainer.viewContext
        
        switch beforeData.type {
            
        case .detail:
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && title = %@ && contents = %@", beforeData.date, beforeData.title, beforeData.contents)
            
            do {
                let result = try context.fetch(fetchRequest)
                let objectUpdate = result[0] as? NSManagedObject
                objectUpdate?.setValue(newData.title, forKey: "title")
                objectUpdate?.setValue(newData.contents, forKey: "contents")
                try context.save()
                
            } catch {
                throw ErrorCase.NOT_UPDATE_DATA
            }
            
        case .simple:
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "SimpleDiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && contents = %@", beforeData.date, beforeData.contents)
            
            do {
                let result = try context.fetch(fetchRequest)
                let objectUpdate = result[0] as? NSManagedObject
                objectUpdate?.setValue(newData.contents, forKey: "contents")
                try context.save()
                
            } catch {
                throw ErrorCase.NOT_UPDATE_DATA
            }
        }
    }
    
    func deleteData(deleteData: DiaryModel) async throws {
        guard let appDelegate = await UIApplication.shared.delegate as? AppDelegate else { throw ErrorCase.NOT_DELETE_DATA }
        let context = await appDelegate.persistentContainer.viewContext
        
        switch deleteData.type {
        case .detail:
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && title = %@ && contents = %@", deleteData.date, deleteData.title, deleteData.contents)
            
            do {
                let test = try context.fetch(fetchRequest)
                guard let objectToDelete = test[0] as? NSManagedObject else { throw ErrorCase.NOT_DELETE_DATA }
                context.delete(objectToDelete)
                try context.save()
                
            } catch {
                throw ErrorCase.NOT_DELETE_DATA
            }
            
        case .simple:
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "SimpleDiaryData")
            fetchRequest.predicate = NSPredicate(format: "date = %@ && contents = %@", deleteData.date, deleteData.contents)
            
            do {
                let test = try context.fetch(fetchRequest)
                guard let objectToDelete = test[0] as? NSManagedObject else { throw ErrorCase.NOT_DELETE_DATA }
                context.delete(objectToDelete)
                try context.save()
                
            } catch {
                throw ErrorCase.NOT_DELETE_DATA
            }
        }
    }
}
