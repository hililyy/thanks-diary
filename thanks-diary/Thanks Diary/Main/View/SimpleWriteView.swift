//
//  SimpleWriteView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/22.
//

import UIKit

final class SimpleWriteView: NSObject {
    private var simpleWriteVC: SimpleWriteVC
    private let mainModel = MainModel.model
    private let maxCount: Int = 23
    
    init(_ simpleWriteVC: SimpleWriteVC) {
        self.simpleWriteVC = simpleWriteVC
    }
    
    func setTextView() {
        if simpleWriteVC.editFlag == true {
            guard let index = simpleWriteVC.selectedIndex else { return }
            if mainModel.loginType == LoginType.none {
                simpleWriteVC.simpleTextField.text = mainModel.shortData[index].contents
            } else {
                simpleWriteVC.simpleTextField.text = mainModel.shortDiaryDatabyDate[index].contents
            }
        }
        simpleWriteVC.textLengthLabel.text = "\(simpleWriteVC.simpleTextField.text.count)/25"
    }
    
    func setUI() {
        simpleWriteVC.simpleTextField.layer.cornerRadius = 15
        simpleWriteVC.simpleTextField.layer.borderWidth = 1
        simpleWriteVC.simpleTextField.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        simpleWriteVC.cancelBtn.layer.borderWidth = 1.5
        simpleWriteVC.cancelBtn.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        simpleWriteVC.cancelBtn.layer.cornerRadius = 10
        simpleWriteVC.okBtn.layer.cornerRadius = 10
    }
}

extension SimpleWriteView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        simpleWriteVC.textLengthLabel.text = "\(textView.text.count+1)/25"
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
