//
//  DetailWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/21.
//

import UIKit
import CoreData

final class DetailWriteVC: BaseVC {
    
    @IBOutlet weak var diaryTitle: UILabel!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var completeBtn: UIButton!
    let mainModel = MainModel.model
    var detailWriteView: DetailWriteView?
    var editFlag: Bool?
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initalize() {
        detailWriteView = DetailWriteView(self)
        detailWriteView?.setView()
        detailWriteView?.setTitle()
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
                self.setRootVC(name: "Main", identifier: "MainVC")
            } else {
                mainModel.updateFirebaseData(
                    diaryType: .detail,
                    selectedIndex: index,
                    afterTitle: titleTextfield.text ?? "",
                    afterContents: contentsTextView.text ?? "") {
                        self.setRootVC(name: "Main", identifier: "MainVC")
                    }
            }
        } else {
            if mainModel.loginType == LoginType.none {
                mainModel.setData(
                    diaryType: .detail,
                    title: self.titleTextfield.text ?? "",
                    contents: self.contentsTextView.text
                )
            } else {
                mainModel.setFirebaseData(
                    diaryType: .detail,
                    title: self.titleTextfield.text ?? "",
                    contents: self.contentsTextView.text)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}
