//
//  MainModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/23.
//

import UIKit
import Foundation
import CoreData

class MainModel {
    static let model = MainModel()
    var detailData: [DiaryEntity] = []
    var simpleData: [SimpleDiaryEntity] = []
    var longDiaryFlag: Bool = false
    var selectedDate: String = ""
    var todayDate: String = ""
    var dateList: [String] = []
    
    func getDetailData(selectedDate: String) {
        detailData = []
        dateList = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DiaryData")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                self.dateList.append(data.value(forKey: "date") as? String ?? "")
                if data.value(forKey: "date") as! String == selectedDate {
                    let tmpEntity = DiaryEntity(
                        type: data.value(forKey: "type") as? String,
                        title: data.value(forKey: "title") as? String,
                        contents: data.value(forKey: "contents") as? String,
                        date: data.value(forKey: "date") as? String
                    )
                detailData.append(tmpEntity)
                }
            }
        } catch let error as NSError {
            print(ErrorCase.NOT_SAVE_DATA)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getSimpleData(selectedDate: String) {
        simpleData = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SimpleDiaryData")
        do {
            let result = try managedContext.fetch(fetchRequest)

            for data in result {
                self.dateList.append(data.value(forKey: "date") as? String ?? "")
                if data.value(forKey: "date") as! String == selectedDate {
                    
                    let tmpEntity = SimpleDiaryEntity(
                        type: data.value(forKey: "type") as? String,
                        contents: data.value(forKey: "contents") as? String,
                        date: data.value(forKey: "date") as? String
                    )
                    simpleData.append(tmpEntity)
                }
            }
        } catch let error as NSError {
            print(ErrorCase.NOT_SAVE_DATA)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateDetailData(dateString: String, titleString: String, contentsString: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
        fetchRequest.predicate = NSPredicate(format: "date = %@", dateString)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let objectUpdate = result[0] as! NSManagedObject
            objectUpdate.setValue(titleString, forKey: "title")
            objectUpdate.setValue(contentsString, forKey: "contents")
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
    
    func updateSimpleData(contentsString: String, afterContentsString: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "SimpleDiaryData")
        fetchRequest.predicate = NSPredicate(format: "contents = %@", contentsString)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let objectUpdate = result[0] as! NSManagedObject
            objectUpdate.setValue(afterContentsString, forKey: "contents")
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
        self.getSimpleData(selectedDate: self.selectedDate)
    }
    
    func deleteDetailData(dateString: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
        fetchRequest.predicate = NSPredicate(format: "date = %@", dateString)
        
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
        detailData = []
    }
    
    func deleteSimpleData(contentsString: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "SimpleDiaryData")
        fetchRequest.predicate = NSPredicate(format: "contents = %@", contentsString)
        
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
        
        self.getSimpleData(selectedDate: self.selectedDate)
    }
    
    func isTodayDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d"
        return formatter.string(from: Date())
    }
    
    func setTodayDate(selectedData: Date) -> String {
        let formatter = DateFormatter()
        let loc = Locale(identifier: "ko_KR")
        formatter.dateFormat = "dd'일' (E)"
        formatter.locale = loc
        return formatter.string(from: selectedData)
    }
}
