//
//  MainModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/23.
//

import UIKit
import Foundation
import CoreData
import Firebase

class MainModel {
    static let model = MainModel()
    var longData: [DiaryEntity] = []
    var shortData: [SimpleDiaryEntity] = []
    var selectedDate: Date = Date()
    var dateWithCircle: [String] = []
    
    var uid: String?
    var longDiaryData: [AllDiaryData.Long] = []
    var shortDiaryData: [AllDiaryData.Short] = []
    //    var diaryData = DiaryDataEntity()
    //    var simpleDiaryData = SimpleDiaryDataEntity()
    
    var authType: String?
    
    func getDetailData(completion: @escaping () -> ()) {
        longData.removeAll()
        dateWithCircle.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DiaryData")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                guard let date = (data.value(forKey: "date") as? String ?? "").convertDate() else { return }
                self.dateWithCircle.append(date.convertString())
                if data.value(forKey: "date") as! String == self.selectedDate.convertString() {
                    let tmpEntity = DiaryEntity(
                        type: data.value(forKey: "type") as? String,
                        title: data.value(forKey: "title") as? String,
                        contents: data.value(forKey: "contents") as? String,
                        date: data.value(forKey: "date") as? String
                    )
                    longData.append(tmpEntity)
                }
            }
            completion()
        } catch let error as NSError {
            print(ErrorCase.NOT_SAVE_DATA)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getSimpleData(completion: @escaping () -> ()) {
        shortData.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SimpleDiaryData")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                guard let date = (data.value(forKey: "date") as? String ?? "").convertDate() else { return }
                self.dateWithCircle.append(date.convertString())
                if data.value(forKey: "date") as! String == self.selectedDate.convertString() {
                    let tmpEntity = SimpleDiaryEntity(
                        type: data.value(forKey: "type") as? String,
                        contents: data.value(forKey: "contents") as? String,
                        date: data.value(forKey: "date") as? String
                    )
                    shortData.append(tmpEntity)
                }
            }
            completion()
        } catch let error as NSError {
            print(ErrorCase.NOT_SAVE_DATA)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func setDetailData(title: String, contents: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DiaryData", in: context)
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(title, forKey: "title")
            managedObject.setValue(contents, forKey: "contents")
            managedObject.setValue(self.selectedDate.convertString(), forKey: "date")
            managedObject.setValue("detail", forKey: "type")
            do {
                try context.save()
                return
            } catch {
                print(ErrorCase.NOT_SAVE_DATA)
                return
            }
        } else { return }
    }
    
    func setSimpleData(contents: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SimpleDiaryData", in: context)
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(contents, forKey: "contents")
            managedObject.setValue(self.selectedDate.convertString(), forKey: "date")
            managedObject.setValue("simple", forKey: "type")
            do {
                try context.save()
                return
            } catch {
                print(ErrorCase.NOT_SAVE_DATA)
                return
            }
        } else {
            return
        }
    }
    
    func updateDetailData(selectedIndex: Int, afterTitle: String, afterContents: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let title = self.longData[selectedIndex].title,
              let contents = self.longData[selectedIndex].contents else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
        fetchRequest.predicate = NSPredicate(format: "date = %@ && title = %@ && contents = %@", self.selectedDate.convertString(), title, contents)
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
    }
    
    func updateSimpleData(selectedIndex: Int, afterContents: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let contents = self.shortData[selectedIndex].contents else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "SimpleDiaryData")
        fetchRequest.predicate = NSPredicate(format: "date = %@ && contents = %@", self.selectedDate.convertString(), contents)
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
    
    func deleteDetailData(selectedIndex: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let title = self.longData[selectedIndex].title,
              let contents = self.longData[selectedIndex].contents
        else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
        fetchRequest.predicate = NSPredicate(format: "date = %@ && title = %@ && contents = %@", self.selectedDate.convertString(), title, contents)
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
    
    func deleteSimpleData(selectedIndex: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let contents = self.shortData[selectedIndex].contents else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "SimpleDiaryData")
        fetchRequest.predicate = NSPredicate(format: "date = %@ && contents = %@", self.selectedDate.convertString(), contents)
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
    
    // MARK: Firebase Code
    func getDetailFirebaseData(completion: @escaping () -> ()) {
        guard let saveUid = uid else { return }
        longDiaryData.removeAll()
        dateWithCircle.removeAll()
        
        Database.database().reference().child(saveUid).child("long").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let data = AllDiaryData.Long(JSON: snap.value as! [String:AnyObject]) else { return }
                if data.date == self.selectedDate.convertString() {
                    self.longDiaryData.append(data)
                    self.dateWithCircle.append(data.date ?? "")
                    print("reload detail data")
                }
            }
            print("detail completion start")
            completion()
            print("detail completion end")
        }
    }
    
    func getSimpleFirebaseData(completion: @escaping () -> ()) {
        guard let saveUid = uid else { return }
        shortDiaryData.removeAll()
        
        Database.database().reference().child(saveUid).child("short").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let data = AllDiaryData.Short(JSON: snap.value as! [String:AnyObject]) else { return }
                if data.date == self.selectedDate.convertString() {
                    self.shortDiaryData.append(data)
                    self.dateWithCircle.append(data.date ?? "")
                }
            }
            completion()
        }
    }
    
    func setFirebaseData(type: DiaryType, title: String? = nil, contents: String) {
        guard let uid = uid else { return }
        switch type {
        case .long :
            let longData: [String:Any] = [
                "title": title ?? "",
                "contents": contents,
                "date": self.selectedDate.convertString()
            ]
            Database.database().reference().child(uid).child("long").childByAutoId().setValue(longData)
        case .short :
            let shortData: [String:Any] = [
                "contents": contents,
                "date": self.selectedDate.convertString()
            ]
            Database.database().reference().child(uid).child("short").childByAutoId().setValue(shortData)
        }
    }
}
