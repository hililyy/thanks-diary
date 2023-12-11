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
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    let detailDiaryModelName: String = "DiaryData"
    let simpleDiaryModelName: String = "SimpleDiaryData"
    
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
        guard let context = self.context else { return [:] }
        
        let request = NSFetchRequest<NSManagedObject>(entityName: detailDiaryModelName)
        var detailData: [String: [DiaryModel]] = [:]
        var detailCoredata: [DiaryData] = []
        
        do {
            guard let result = try context.fetch(request) as? [DiaryData] else { return [:] }
            
            detailCoredata = result
            
            for data in detailCoredata {
                
                guard let title = data.title,
                      let contents = data.contents,
                      let date = data.date else { return [:] }
                
                let diary = DiaryModel(
                    type: .detail,
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
        guard let context = self.context else { return [:] }
        
        let request = NSFetchRequest<NSManagedObject>(entityName: simpleDiaryModelName)
        var simpleData: [String: [DiaryModel]] = [:]
        var simpleCoreData: [SimpleDiaryData] = []
        
        do {
            guard let result = try context.fetch(request) as? [SimpleDiaryData] else { return [:] }
            
            simpleCoreData = result
            
            for data in simpleCoreData {
                
                guard let contents = data.contents,
                      let date = data.date else { return [:] }
                
                let diary = DiaryModel(
                    type: .simple,
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
            
        } catch {
            return nil
        }
    }
    
    func setData(newData: DiaryModel) async throws {
        guard let context = self.context else { return }
        
        switch newData.type {
        case .detail:
            guard let entity = NSEntityDescription.entity(forEntityName: detailDiaryModelName, in: context),
                  let diaryData = NSManagedObject(entity: entity, insertInto: context) as? DiaryData else { return }
            diaryData.title = newData.title
            diaryData.contents = newData.contents
            diaryData.date = newData.date
            diaryData.type = newData.type.rawValue
            
        case .simple:
            guard let entity = NSEntityDescription.entity(forEntityName: simpleDiaryModelName, in: context),
                  let simpleDiaryData = NSManagedObject(entity: entity, insertInto: context) as? SimpleDiaryData else { return }
            simpleDiaryData.contents = newData.contents
            simpleDiaryData.date = newData.date
            simpleDiaryData.type = newData.type.rawValue
        }
        
        saveContext(context: context)
    }
    
    func updateData(beforeData: DiaryModel, newData: DiaryModel) async throws {
        guard let context = self.context else { return }
        
        switch beforeData.type {
        case .detail:
            let request = NSFetchRequest<NSManagedObject>(entityName: detailDiaryModelName)
            request.predicate = NSPredicate(format: "date = %@ && title = %@ && contents = %@", beforeData.date, beforeData.title, beforeData.contents)
            
            do {
                guard let fetchedDiaryDatas = try context.fetch(request) as? [DiaryData],
                      !fetchedDiaryDatas.isEmpty,
                      let targetDiary = fetchedDiaryDatas.first else { throw ErrorCase.NOT_UPDATE_DATA }
                
                targetDiary.title = newData.title
                targetDiary.contents = newData.contents
            } catch {
                throw ErrorCase.NOT_UPDATE_DATA
            }
            
        case .simple:
            let request = NSFetchRequest<NSManagedObject>(entityName: simpleDiaryModelName)
            request.predicate = NSPredicate(format: "date = %@ && contents = %@", beforeData.date, beforeData.contents)
            
            do {
                guard let fetchSimpleDiaryData = try context.fetch(request) as? [SimpleDiaryData],
                      !fetchSimpleDiaryData.isEmpty,
                      let targetDiary = fetchSimpleDiaryData.first else { throw ErrorCase.NOT_UPDATE_DATA }
                
                targetDiary.contents = newData.contents
                
            } catch {
                throw ErrorCase.NOT_UPDATE_DATA
            }
        }
        
        saveContext(context: context)
    }
    
    func deleteData(deleteData: DiaryModel) async throws {
        guard let context = self.context else { return }
        
        switch deleteData.type {
        case .detail:
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
            request.predicate = NSPredicate(format: "date = %@ && title = %@ && contents = %@", deleteData.date, deleteData.title, deleteData.contents)
            
            do {
                guard let fetchedDiaryDatas = try context.fetch(request) as? [DiaryData],
                      !fetchedDiaryDatas.isEmpty,
                      let targetDiary = fetchedDiaryDatas.first else { throw ErrorCase.NOT_DELETE_DATA }
                
                context.delete(targetDiary)
                
            } catch {
                throw ErrorCase.NOT_DELETE_DATA
            }
            
        case .simple:
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "SimpleDiaryData")
            request.predicate = NSPredicate(format: "date = %@ && contents = %@", deleteData.date, deleteData.contents)
            
            do {
                guard let fetchSimpleDiaryData = try context.fetch(request) as? [SimpleDiaryData],
                      !fetchSimpleDiaryData.isEmpty,
                      let targetDiary = fetchSimpleDiaryData.first else { throw ErrorCase.NOT_DELETE_DATA }
                
                context.delete(targetDiary)
                
            } catch {
                throw ErrorCase.NOT_DELETE_DATA
            }
        }
        
        saveContext(context: context)
    }
    
    func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
