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
    var longDiaryDatabyDate: [AllDiaryData.Long] = []
    var shortDiaryDatabyDate: [AllDiaryData.Short] = []
    var longKey: [String] = []
    var shortKey: [String] = []
    var longKeybyDate: [String] = []
    var shortKeybyDate: [String] = []
    var authType: String?
    
    func getDetailData(type: String? = "none", completion: @escaping () -> ()) {
        longData.removeAll()
        dateWithCircle.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DiaryData")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                guard let date = (data.value(forKey: "date") as? String ?? "").convertDate() else { return }
                if type == "none" {
                    self.dateWithCircle.append(date.convertString())
                    if data.value(forKey: "date") as! String == self.selectedDate.convertString() {
                        let tmpEntity = DiaryEntity(
                            type: data.value(forKey: "type") as? String,
                            title: data.value(forKey: "title") as? String,
                            contents: data.value(forKey: "contents") as? String,
                            date: data.value(forKey: "date") as? String
                        )
                        print("담긴다")
                        longData.append(tmpEntity)
                    }
                } else {
                    let tmpEntity = DiaryEntity(
                        type: data.value(forKey: "type") as? String,
                        title: data.value(forKey: "title") as? String,
                        contents: data.value(forKey: "contents") as? String,
                        date: data.value(forKey: "date") as? String
                    )
                    print("담긴다")
                    longData.append(tmpEntity)
                }
            }
            completion()
        } catch let error as NSError {
            print(ErrorCase.NOT_SAVE_DATA)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getSimpleData(type: String? = "none", completion: @escaping () -> ()) {
        shortData.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SimpleDiaryData")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                guard let date = (data.value(forKey: "date") as? String ?? "").convertDate() else { return }
                if type == "none" {
                    self.dateWithCircle.append(date.convertString())
                    if data.value(forKey: "date") as! String == self.selectedDate.convertString() {
                        let tmpEntity = SimpleDiaryEntity(
                            type: data.value(forKey: "type") as? String,
                            contents: data.value(forKey: "contents") as? String,
                            date: data.value(forKey: "date") as? String
                        )
                        shortData.append(tmpEntity)
                    }
                } else {
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
    
    
    // MARK: Firebase Code
    func getDetailFirebaseData(completion: @escaping () -> ()) {
        guard let saveUid = uid else { return }
        longDiaryData.removeAll()
        longKey.removeAll()
        dateWithCircle.removeAll()
        
        Database.database().reference().child(saveUid).child("long").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let data = AllDiaryData.Long(JSON: snap.value as! [String:AnyObject]) else { return }
                self.dateWithCircle.append(data.date ?? "")
                self.longKey.append(snap.key)
                self.longDiaryData.append(data)
            }
            completion()
        }
    }
    
    func getSimpleFirebaseData(completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        shortDiaryData.removeAll()
        shortKey.removeAll()
        
        Database.database().reference().child(uid).child("short").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let data = AllDiaryData.Short(JSON: snap.value as! [String:AnyObject]) else { return }
                self.dateWithCircle.append(data.date ?? "")
                self.shortKey.append(snap.key)
                self.shortDiaryData.append(data)
            }
            completion()
        }
    }
    
    func setFirebaseData(type: DiaryType, title: String? = nil, contents: String, date: String? = "none") {
        guard let uid = uid else { return }
        var newDate: String?
        if date == "none" {
            newDate = self.selectedDate.convertString()
        } else {
            newDate = date
        }
        switch type {
        case .long :
            let longData: [String:Any] = [
                "title": title ?? "",
                "contents": contents,
                "date": newDate ?? ""
            ]
            Database.database().reference().child(uid).child("long").childByAutoId().setValue(longData)
        case .short :
            let shortData: [String:Any] = [
                "contents": contents,
                "date": newDate ?? ""
            ]
            Database.database().reference().child(uid).child("short").childByAutoId().setValue(shortData)
        }
    }
    
    func updateDetailFirebaseData(selectedIndex: Int, afterTitle: String, afterContents: String, completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        let diary: [String:Any] = [
            "title": afterTitle,
            "contents": afterContents,
            "date": self.selectedDate.convertString()
        ]
        Database.database().reference().child(uid).child("long").child(longKeybyDate[selectedIndex]).updateChildValues(diary)
        completion()
    }
    
    func updateSimpleFirebaseData(selectedIndex: Int, afterContents: String, completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        let diary: [String:Any] = [
            "contents": afterContents,
            "date": self.selectedDate.convertString()
        ]
        Database.database().reference().child(uid).child("short").child(shortKeybyDate[selectedIndex]).updateChildValues(diary)
        completion()
    }
    
    func deleteDetailFirebaseData(selectedIndex: Int, completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        Database.database().reference().child(uid).child("long").child(longKeybyDate[selectedIndex]).removeValue()
        completion()
    }
    
    func deleteSimpleFirebaseData(selectedIndex: Int, completion: @escaping () -> ()) {
        guard let uid = uid else { return }
        Database.database().reference().child(uid).child("short").child(shortKeybyDate[selectedIndex]).removeValue()
        completion()
    }
}
