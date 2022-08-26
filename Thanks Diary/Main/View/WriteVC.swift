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
        
    }
        
    func setData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "DiaryData", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(self.titleString, forKeyPath: "title")
        user.setValue(self.contentsString, forKeyPath: "contents")
        user.setValue(self.todayDate, forKeyPath: "date")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("error : \(error)")
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
