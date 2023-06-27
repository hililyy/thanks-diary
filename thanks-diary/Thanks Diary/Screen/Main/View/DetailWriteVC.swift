//
//  DetailWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/21.
//

import UIKit
import CoreData
import Toast_Swift

class DetailWriteVC: BaseVC {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var completeBtn: UIButton!
    
    var updateFlag: Bool = false
    var parentVC: MainVC?
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTitle()
    }
    
    private func setView() {
        completeBtn.layer.cornerRadius = 10
        
        titleTextfield.layer.cornerRadius = 20
        titleTextfield.layer.borderWidth = 2
        titleTextfield.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        titleTextfield.addLeftPadding()
        
        contentsTextView.layer.cornerRadius = 20
        contentsTextView.layer.borderWidth = 2
        contentsTextView.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        contentsTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
    }
    
    private func setTitle() {
        if let date = parentVC?.viewModel.selectedDate.convertString(format: "yyyy년 M월 d일") {
            titleLabel.text = date + " 감사일기"
        } else {
            titleLabel.text = "오늘의 감사일기"
        }
        
        if updateFlag == true {
            guard let index = selectedIndex else { return }
            
            titleTextfield.text = parentVC?.viewModel.selectedDetailData[index].title
            contentsTextView.text = parentVC?.viewModel.selectedDetailData[index].contents
        }
    }

    @IBAction func goBack(_ sender: Any) {
        back(animated: true)
    }
    
    @IBAction func goComplete(_ sender: Any) {
        
        guard let title = titleTextfield.text,
              let contents = contentsTextView.text else { return }
        
        if title.isEmpty || contents.isEmpty {
            self.view.makeToast("제목과 내용을 모두 입력해 주세요.")
        } else {
            if updateFlag == true {
                guard let index = selectedIndex else { return }
                
                parentVC?.viewModel.updateDetailData(
                    selectedIndex: index,
                    afterTitle: title,
                    afterContents: contents) { result in
                        if result {
                            self.parentVC?.viewModel.getAllDiaryData {
                                self.parentVC?.viewModel.getSelectedDiaryData {
                                    self.back(animated: true)
                                }
                            }
                        } else {
                            self.presentErrorPopup()
                        }
                    }
            } else {
                parentVC?.viewModel.setDetailData(title: title, contents: contents) { result in
                    if result {
                        self.back(animated: true)
                    } else {
                        self.presentErrorPopup()
                    }
                }
            }
        }
    }
}
