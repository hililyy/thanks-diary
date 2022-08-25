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
    var titleString: String?
    var contentsString: String?
    var todayDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.completeBtn.layer.cornerRadius = 20
        
        self.titleTextfield.layer.cornerRadius = 20
        self.titleTextfield.layer.borderWidth = 1
        self.titleTextfield.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        
        self.contentsTextView.layer.cornerRadius = 20
        self.contentsTextView.layer.borderWidth = 1
        self.contentsTextView.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
    }
        
    func setData() {
        let entity = NSEntityDescription.entity(forEntityName: "DiaryData", in: self.container.viewContext)
        
        let diary = NSManagedObject(entity: entity!, insertInto: self.container.viewContext)
        diary.setValue(self.titleString, forKey: "title")
        diary.setValue(self.contentsString, forKey: "contents")
        diary.setValue(self.todayDate, forKey: "date")
        
        do{
            try self.container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goComplete(_ sender: Any) {
        self.titleString = titleTextfield.text ?? ""
        self.contentsString = contentsTextView.text
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.todayDate = formatter.string(from: Date())
        setData()
        self.navigationController?.popViewController(animated: true)
    }
}
