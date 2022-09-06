//
//  WriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/21.
//

import UIKit
import CoreData

class WriteVC: UIViewController {

    @IBOutlet weak var diaryTitle: UILabel!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var completeBtn: UIButton!
    var container: NSPersistentContainer!
    var titleString: String = ""
    var contentsString: String = ""
    var todayString: String = ""
    let model = MainModel.model
    var editFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.completeBtn.layer.cornerRadius = 20
        
        self.titleTextfield.layer.cornerRadius = 20
        self.titleTextfield.layer.borderWidth = 1
        self.titleTextfield.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        
        self.contentsTextView.layer.cornerRadius = 20
        self.contentsTextView.layer.borderWidth = 1
        self.contentsTextView.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        
        setTitle()
        
        if editFlag == true {
            self.titleTextfield.text = titleString
            self.contentsTextView.text = contentsString
            self.diaryTitle.text = todayString
        }
    }
        
    func setData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "DiaryData", in: context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            
            managedObject.setValue(self.titleString, forKey: "title")
            managedObject.setValue(self.contentsString, forKey: "contents")
            managedObject.setValue(self.todayString, forKey: "date")
            managedObject.setValue("detail", forKey: "type")
            
            do {
                try context.save()
                return
            } catch {
                print(error.localizedDescription)
                return
            }
        } else {
            return
        }
}
    
    func setTitle() {
        self.todayString = changeDateToString(date: Date(), formatString: "yyyy년 M월 d일")
        self.diaryTitle.text = "\(todayString) 감사일기"
    }
    
    func changeDateToString(date: Date, formatString: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = formatString
        return dateFormatter.string(from: date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goComplete(_ sender: Any) {
        if model.longDiaryFlag == false {
            model.longDiaryFlag = true
            LocalDataStore.localDataStore.setTodayDetailData(newData: true)
            self.titleString = titleTextfield.text ?? ""
            self.contentsString = contentsTextView.text
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.todayString = formatter.string(from: Date())
            setData()
            self.navigationController?.popViewController(animated: true)
        } else {
            // 오늘 더 작성 못한다고 팝업
            print("더 못씀")
        }
        // update
        if editFlag == true {
            LocalDataStore.localDataStore.setTodayDetailData(newData: true)
            self.titleString = titleTextfield.text ?? ""
            self.contentsString = contentsTextView.text
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.todayString = formatter.string(from: Date())
            model.updateDetailData(dateString: self.todayString, titleString: self.titleString, contentsString: self.contentsString)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}

