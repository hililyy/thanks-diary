//
//  DetailWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/21.
//

import UIKit
import CoreData
import Toast_Swift

class DetailWriteVC: UIViewController {

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
        setView()
        setTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setView() {
        self.completeBtn.layer.cornerRadius = 10
        
        self.titleTextfield.layer.cornerRadius = 20
        self.titleTextfield.layer.borderWidth = 2
        self.titleTextfield.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        
        self.contentsTextView.layer.cornerRadius = 20
        self.contentsTextView.layer.borderWidth = 2
        self.contentsTextView.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        
        titleTextfield.addLeftPadding()
        contentsTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
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
                print(ErrorCase.NOT_SAVE_DATA)
                self.view.makeToast("일기 저장에 실패했습니다.")
                return
            }
        } else {
            return
        }
}
    
    func setTitle() {
        if editFlag == false {
            self.todayString = changeDateToString(date: Date(), formatString: "yyyy년 M월 d일")
            self.diaryTitle.text = "\(todayString) 감사일기"
        } else {
            var tmpString = todayString.split(separator: "-")
            self.diaryTitle.text = ("\(tmpString[0])년 \(tmpString[1])월 \(tmpString[2])일 감사일기")
            self.titleTextfield.text = titleString
            self.contentsTextView.text = contentsString
        }
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
        do{
            // update
            if editFlag == true {
                try setString()
                model.updateDetailData(dateString: self.todayString, titleString: self.titleString, contentsString: self.contentsString)
                goMainVC()
            // create
            } else {
                model.longDiaryFlag = true
                try setString()
                setData()
                self.navigationController?.popViewController(animated: true)
            }
        } catch {
            print(ErrorCase.NOT_SAVE_DATA)
        }
    }
    
    func setString() throws {
        LocalDataStore.localDataStore.setTodayDetailData(newData: true)
        self.titleString = titleTextfield.text ?? ""
        self.contentsString = contentsTextView.text
        
        guard self.titleString == "" || self.contentsString == "" else {
            throw ErrorCase.EMPTY_CONTENTS
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d"
        self.todayString = formatter.string(from: Date())
    }
    
    func goMainVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}



extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}

