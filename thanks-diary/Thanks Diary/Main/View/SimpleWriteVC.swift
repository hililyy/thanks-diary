//
//  SimpleWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/05.
//

import UIKit
import CoreData

class SimpleWriteVC: UIViewController {
    //20자까지 작성
    @IBOutlet weak var simpleTextField: UITextView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var textLengthLabel: UILabel!
    weak var delegate: reloadDelegate?
    let mainModel = MainModel.model
    var editFlag: Bool?
    var selectedIndex: Int?
    let maxCount: Int = 23
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.simpleTextField.becomeFirstResponder()
    }
    
    func setTextView() {
        self.simpleTextField.delegate = self
        if editFlag == true {
            guard let index = selectedIndex else { return }
            simpleTextField.text = mainModel.shortData[index].contents
        }
        self.textLengthLabel.text = "\(simpleTextField.text.count)/25"
    }
    
    func setUI() {
        self.simpleTextField.layer.cornerRadius = 15
        self.simpleTextField.layer.borderWidth = 1
        self.simpleTextField.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        self.cancelBtn.layer.borderWidth = 1.5
        self.cancelBtn.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        self.cancelBtn.layer.cornerRadius = 10
        self.okBtn.layer.cornerRadius = 10
    }
    
    @IBAction func goEnter(_ sender: Any) {
        if editFlag == true {
            guard let index = selectedIndex,
                  let contents = self.simpleTextField.text else { return }
            mainModel.updateSimpleData(selectedIndex: index, afterContents: contents)
            self.dismiss(animated: true) {
                self.delegate?.reloadData()
            }
        } else {
            mainModel.setSimpleData(contents: self.simpleTextField.text)
            self.dismiss(animated: true) {
                self.delegate?.reloadData()
            }
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func goDelete(_ sender: Any) {
        guard let index = selectedIndex else { return }
        mainModel.deleteSimpleData(selectedIndex: index)
        self.dismiss(animated: true) {
            self.delegate?.reloadData()
        }
    }
}

extension SimpleWriteVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.textLengthLabel.text = "\(textView.text.count+1)/25"
        let newLength = textView.text.count - range.length + text.count
        let koreanMaxCount = maxCount + 1
        if newLength > koreanMaxCount {
            let overflow = newLength - koreanMaxCount
            if text.count < overflow { return true }
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
            textView.text.removeLast()
        }
    }
}
