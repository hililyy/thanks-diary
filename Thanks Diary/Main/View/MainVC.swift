//
//  MainVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit
import FSCalendar
import Floaty
import CoreData

class MainVC: UIViewController {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var diaryTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    var tmpData: [DiaryEntity] = []
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.diaryTableView.delegate = self
        self.diaryTableView.dataSource = self
        setFloty()
        setCalender()
        setDiaryData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        getData()
    }
    
    func setDiaryData() {
        
    }

    func getData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            // Entity의 fetchRequest 생성
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DiaryData")
        do {
            let result = try managedContext.fetch(fetchRequest)

            for data in result {
                print(data.value(forKey: "title") as! String)
                print(data.value(forKey: "contents") as! String)
                print(data.value(forKey: "date") as! String)
                let tmpEntity = DiaryEntity(
                    id: 1,
                    category: "long",
                    title: data.value(forKey: "title") as? String,
                    contents: data.value(forKey: "contents") as? String,
                    date: data.value(forKey: "date") as? String
                )
                tmpData.append(tmpEntity)
            }
            print(result)
            print(tmpData)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
        fetchRequest.predicate = NSPredicate(format: "title = 123")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let objectUpdate = result[0] as! NSManagedObject
            print(result)
            objectUpdate.setValue("newName", forKey: "title")
            objectUpdate.setValue("newContents", forKey: "contents")
            print(result)
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DiaryData")
        fetchRequest.predicate = NSPredicate(format: "title = 123")
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            print(test)
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            print(test)
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func setFloty() {
        let floaty = Floaty()
        floaty.buttonColor = UIColor(named: "mainColor")!
        floaty.plusColor = UIColor(named: "whiteColor")!
        floaty.addItem("간단하게", icon: UIImage(named: "ic_simple_write")!)
        floaty.addItem("자세하게", icon: UIImage(named: "ic_detail_write")!, handler: { item in
            guard let vc =  self.storyboard?.instantiateViewController(identifier: "WriteVC") as? WriteVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            floaty.close()
        })
        self.view.addSubview(floaty)
    }
    
    func setCalender() {
        self.calendar.delegate = self
        self.calendar.dataSource = self
        self.calendar.locale = Locale(identifier: "ko_KR")
        self.calendar.appearance.headerDateFormat = "YYYY년 M월"
        
        self.calendar.appearance.headerTitleColor = UIColor(named: "grayColor_1")
        self.calendar.appearance.headerTitleFont = UIFont(name: "KOTRA_GOTHIC", size: 19)
        self.calendar.appearance.titleFont = UIFont(name: "KOTRA_GOTHIC", size: 17)
        self.calendar.appearance.weekdayFont = UIFont(name: "KOTRA_GOTHIC", size: 17)
        self.calendar.appearance.subtitleFont = UIFont(name: "KOTRA_GOTHIC", size: 17)
        
        self.calendar.appearance.weekdayTextColor = UIColor(named: "grayColor_1")
        self.calendar.appearance.calendar.headerHeight = 50
        self.calendar.weekdayHeight = 30
        self.calendar.rowHeight = 40
    }
    

    @IBAction func goSetting(_ sender: Any) {
        guard let vc =  storyboard?.instantiateViewController(identifier: "SettingVC") as? SettingVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tmpData.count == 0 {
            self.emptyView.isHidden = false
            diaryTableView.isScrollEnabled = false
            return 0
        } else {
            self.emptyView.isHidden = true
            self.emptyView.frame.size.height = 0
            return tmpData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = diaryTableView.dequeueReusableCell(withIdentifier: "MainDiaryListCell", for: indexPath)
        return cell
    }
}
