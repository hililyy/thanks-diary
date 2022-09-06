//
//  SimpleWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/05.
//

import UIKit
import CoreData

class SimpleWriteVC: UIViewController {

    @IBOutlet weak var simpleTextField: UITextView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    var contentsString: String = ""
    var todayString: String = ""
    weak var delegate: reloadDelegate?
    let model = MainModel.model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.simpleTextField.layer.cornerRadius = 20
        self.simpleTextField.layer.borderWidth = 1
        self.simpleTextField.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        
        self.okBtn.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.simpleTextField.becomeFirstResponder()
    }
    
    func setData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "SimpleDiaryData", in: context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(self.contentsString, forKey: "contents")
            managedObject.setValue(self.todayString, forKey: "date")
            managedObject.setValue("simple", forKey: "type")
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
    
    @IBAction func goEnter(_ sender: Any) {
            
            self.contentsString = simpleTextField.text ?? ""
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.todayString = formatter.string(from: Date())
            setData()
            let tmpEntity = SimpleDiaryEntity(
                type: "simple",
                contents: self.contentsString,
                date: self.todayString
            )
            model.simpleData.insert(tmpEntity, at: 0)
//            model.simpleData.append(tmpEntity)
            self.dismiss(animated: true, completion: {
                self.delegate?.sendData()
            })

    }
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

protocol reloadDelegate: AnyObject {
    func sendData()
}
