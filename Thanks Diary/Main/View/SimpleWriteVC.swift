//
//  SimpleWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/05.
//

import UIKit
import CoreData

class SimpleWriteVC: UIViewController, UITextViewDelegate {
//20자까지 작성
    @IBOutlet weak var simpleTextField: UITextView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var textLengthLabel: UILabel!
    var afterContentsString: String = ""
    var contentsString: String = ""
    var todayString: String = ""
    weak var delegate: reloadDelegate?
    let model = MainModel.model
    var updateFlag: Bool = false
    var selectedIndex: Int = 0
    let maxCount: Int = 18
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.simpleTextField.layer.cornerRadius = 15
        self.simpleTextField.layer.borderWidth = 1
        self.simpleTextField.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        self.cancelBtn.layer.borderWidth = 1.5
        self.cancelBtn.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        self.cancelBtn.layer.cornerRadius = 10
        
        self.okBtn.layer.cornerRadius = 10
        
        self.simpleTextField.delegate = self
        if updateFlag == true {
            simpleTextField.text = self.contentsString
        }
        self.textLengthLabel.text = "\(simpleTextField.text.count)/20"
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
        if updateFlag == true {
            self.afterContentsString = self.simpleTextField.text
            model.updateSimpleData(contentsString: self.contentsString, afterContentsString: self.afterContentsString)
            
            self.dismiss(animated: true, completion: {
                self.delegate?.reloadData()
            })
        } else {
            self.contentsString = simpleTextField.text ?? ""
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-M-d"
            self.todayString = formatter.string(from: Date())
            setData()
            let tmpEntity = SimpleDiaryEntity(
                type: "simple",
                contents: self.contentsString,
                date: self.todayString
            )
            model.simpleData.insert(tmpEntity, at: 0)
            self.dismiss(animated: true, completion: {
                self.delegate?.reloadData()
            })
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func goDelete(_ sender: Any) {
        model.deleteSimpleData(contentsString: self.contentsString)
        
        self.dismiss(animated: true, completion: {
            self.delegate?.reloadData()
        })
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //이전 글자 - 선택된 글자 + 새로운 글자(대체될 글자)
        print(textView.text.count)
        self.textLengthLabel.text = "\(textView.text.count+1)/20"
        let newLength = textView.text.count - range.length + text.count
        let koreanMaxCount = maxCount + 1
        //글자수가 초과 된 경우 or 초과되지 않은 경우
        if newLength > koreanMaxCount { //11글자
            let overflow = newLength - koreanMaxCount //초과된 글자수
            if text.count < overflow {
                return true
            }
            let index = text.index(text.endIndex, offsetBy: -overflow)
            let newText = text[..<index]
            guard let startPosition = textView.position(from: textView.beginningOfDocument, offset: range.location) else { return false }
            guard let endPosition = textView.position(from: textView.beginningOfDocument, offset: NSMaxRange(range)) else { return false }
            guard let textRange = textView.textRange(from: startPosition, to: endPosition) else { return false }
                
            textView.replace(textRange, withText: String(newText))
            
            return false
        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count > maxCount {
        //글자수 제한에 걸리면 마지막 글자를 삭제함.
            textView.text.removeLast()
        }
    }
}

protocol reloadDelegate: AnyObject {
    func reloadData()
}
