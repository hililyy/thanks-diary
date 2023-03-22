//
//  SimpleWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/05.
//

import UIKit
import CoreData

final class SimpleWriteVC: UIViewController {
    
    @IBOutlet weak var simpleTextField: UITextView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var textLengthLabel: UILabel!
    weak var noneReloadDelegate: reloadDelegate?
    weak var firebaseReloadDelegate: reloadFirebaseDelegate?
    
    let mainModel = MainModel.model
    var simpleWriteView: SimpleWriteView?
    var editFlag: Bool?
    var selectedIndex: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.simpleTextField.becomeFirstResponder()
    }
    
    func initalize() {
        simpleWriteView = SimpleWriteView(self)
        simpleWriteView?.setUI()
        simpleWriteView?.setTextView()
        self.simpleTextField.delegate = simpleWriteView
    }
    
    @IBAction func goEnter(_ sender: Any) {
        if editFlag == true {
            guard let index = selectedIndex,
                  let contents = self.simpleTextField.text else { return }
            if mainModel.loginType == LoginType.none {
                mainModel.updateData(diaryType: .simple, selectedIndex: index, afterContents: contents)
                self.dismiss(animated: true) {
                    self.noneReloadDelegate?.reloadData()
                }
            } else {
                mainModel.updateFirebaseData(diaryType: .simple, selectedIndex: index, afterContents: contents) {
                    self.dismiss(animated: true) {
                        self.firebaseReloadDelegate?.reloadFirebaseData()
                    }
                }
            }
        } else {
            if mainModel.loginType == LoginType.none {
                mainModel.setData(
                    diaryType: .simple,
                    contents: self.simpleTextField.text
                )
                self.dismiss(animated: true) {
                    self.noneReloadDelegate?.reloadData()
                }
            } else {
                mainModel.setFirebaseData(
                    diaryType: .simple,
                    contents: self.simpleTextField.text
                )
                self.dismiss(animated: true) {
                    self.firebaseReloadDelegate?.reloadFirebaseData()
                }
            }
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func goDelete(_ sender: Any) {
        guard let index = selectedIndex else { return }
        if mainModel.loginType == LoginType.none {
            mainModel.deleteData(diaryType: .simple, selectedIndex: index)
            self.dismiss(animated: true) {
                self.noneReloadDelegate?.reloadData()
            }
        } else {
            mainModel.deleteFirebaseData(diaryType: .simple, selectedIndex: index) {
                self.dismiss(animated: true) {
                    self.firebaseReloadDelegate?.reloadFirebaseData()
                }
            }
        }
    }
}
