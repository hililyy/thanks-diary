//
//  SimpleWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/05.
//

import UIKit
import CoreData
import Toast_Swift

class SimpleWriteVC: BaseVC, UITextViewDelegate {
//20자까지 작성
    @IBOutlet weak var contentsTextField: UITextView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textLengthLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var afterContentsString: String = ""
    var contentsString: String = ""
    var todayString: String = ""
    var delegate: reloadDelegate? = nil
    var updateFlag: Bool = false
    var selectedIndex: Int?
    let maxCount: Int = 23
    var parentVC: MainVC?
    
    override func viewDidLoad() {
        contentsTextField.delegate = self
        
        setUI()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentsTextField.becomeFirstResponder()
    }
    
    func setUI() {
        contentsTextField.layer.cornerRadius = 15
        contentsTextField.layer.borderWidth = 1
        contentsTextField.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 1.5
        cancelButton.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
        
        okButton.layer.cornerRadius = 10
        
        if updateFlag == true {
            deleteButton.isHidden = false
        } else {
            deleteButton.isHidden = true
        }
    }
    
    func setData() {
        if updateFlag == true {
            guard let index = selectedIndex else { return }
            contentsTextField.text = parentVC?.viewModel.selectedSimpleData[index].contents
        }
        textLengthLabel.text = "\(contentsTextField.text.count)/25"
    }
    
    @IBAction func goEnter(_ sender: Any) {
        guard let contents = contentsTextField.text else { return }
        
        if contents.isEmpty {
            okButton.isEnabled = false
            toast(message: "내용을 입력해 주세요.", withDuration: 0.5, delay: 1.5, type: "top") {
                self.okButton.isEnabled = true
            }
        } else {
            if updateFlag == true {
                guard let index = selectedIndex else { return }
                
                parentVC?.viewModel.updateSimpleData(
                    selectedIndex: index,
                    afterContents: contents) { result in
                        if result {
                            self.dismiss(animated: true) {
                                self.delegate?.reloadData()
                            }
                        } else {
                            self.presentErrorPopup()
                        }
                    }
            } else {
                parentVC?.viewModel.setSimpleData(contents: contents) { result in
                        if result {
                            self.dismiss(animated: true) {
                                self.delegate?.reloadData()
                            }
                        } else {
                            self.presentErrorPopup()
                        }
                    }
            }
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func goDelete(_ sender: Any) {
        guard let index = selectedIndex else { return }
        
        parentVC?.viewModel.deleteSimpleData(selectedIndex: index) { result in
            if result {
                self.dismiss(animated: true) {
                    self.delegate?.reloadData()
                }
            } else {
                self.presentErrorPopup()
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //이전 글자 - 선택된 글자 + 새로운 글자(대체될 글자)
        self.textLengthLabel.text = "\(textView.text.count+1)/25"
        let newLength = textView.text.count - range.length + text.count
        let koreanMaxCount = maxCount + 1
        
        //글자수가 초과 된 경우 or 초과되지 않은 경우
        if newLength > koreanMaxCount {
            let overflow = newLength - koreanMaxCount //초과된 글자수
            if text.count < overflow { return true }
            let index = text.index(text.endIndex, offsetBy: -overflow)
            let newText = text[..<index]
            
            guard let startPosition = textView.position(from: textView.beginningOfDocument, offset: range.location),
                  let endPosition = textView.position(from: textView.beginningOfDocument, offset: NSMaxRange(range)),
                  let textRange = textView.textRange(from: startPosition, to: endPosition)
            else { return false }
            
            textView.replace(textRange, withText: String(newText))
            
            return false
        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count > maxCount {
        //글자수 제한에 걸리면 마지막 글자 삭제
            textView.text.removeLast()
        }
    }
}
