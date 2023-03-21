//
//  DetailWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/21.
//

import UIKit
import CoreData

final class DetailWriteVC: UIViewController {
    
    @IBOutlet weak var diaryTitle: UILabel!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var completeBtn: UIButton!
    var writeDate: Date = Date()
    let mainModel = MainModel.model
    var editFlag: Bool?
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goComplete(_ sender: Any) {
        if editFlag == true {
            guard let index = selectedIndex else { return }
            if mainModel.loginType == LoginType.none {
                mainModel.updateData(
                    diaryType: .detail,
                    selectedIndex: index,
                    afterTitle: titleTextfield.text ?? "",
                    afterContents: contentsTextView.text ?? "")
                showMainVC()
            } else {
                mainModel.updateFirebaseData(diaryType: .detail, selectedIndex: index, afterTitle: titleTextfield.text ?? "", afterContents: contentsTextView.text ?? "") {
                    self.showMainVC()
                }
            }
        } else {
            if mainModel.loginType == LoginType.none {
                mainModel.setData(diaryType: .detail, title: self.titleTextfield.text ?? "", contents: self.contentsTextView.text)
            } else {
                mainModel.setFirebaseData(type: .detail, title: self.titleTextfield.text ?? "", contents: self.contentsTextView.text)
            }
            self.navigationController?.popViewController(animated: true)
        }
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
    
    func setTitle() {
        self.diaryTitle.text = "\(mainModel.selectedDate.convertString(format: "yyyy년 M월 d일")) 감사일기"
        if editFlag == true {
            guard let index = selectedIndex else { return }
            if mainModel.loginType == LoginType.none {
                self.titleTextfield.text = mainModel.longData[index].title
                self.contentsTextView.text = mainModel.longData[index].contents
            } else {
                self.titleTextfield.text = mainModel.longDiaryDatabyDate[index].title
                self.contentsTextView.text = mainModel.longDiaryDatabyDate[index].contents
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
