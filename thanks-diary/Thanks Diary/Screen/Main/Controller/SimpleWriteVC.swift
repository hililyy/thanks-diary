//
//  SimpleWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/05.
//

import UIKit

final class SimpleWriteVC: BaseVC {
    
    // MARK: - Property
    
    var delegate: reloadDelegate?
    var updateFlag: Bool = false
    var selectedIndex: Int?
    let maxCount: Int = 22
    var parentVC: MainVC?
    let simpleWriteView = SimpleWriteView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = simpleWriteView
    }
    
    override func viewDidLoad() {
        simpleWriteView.contentsTextView.delegate = self
        
        configureUI()
        setTarget()
    }
    
    // MARK: - Function
    
    private func configureUI() {
        
        simpleWriteView.setHiddenForDeleteButton(!updateFlag)
        
        if updateFlag == true {
            guard let index = selectedIndex,
                  let text = parentVC?.viewModel.selectedSimpleData[index].contents else { return }
            simpleWriteView.setContentsTextView(text: text)
        }
    }
    
    private func setTarget() {
        simpleWriteView.completeButtonTapHandler = {
            let contents = self.simpleWriteView.getContentsTextViewText()
            
            if contents.isEmpty {
                // 텍스트 뷰가 비어있으면 토스트 띄움
                self.simpleWriteView.setCompleteButtonEnable(false)
                self.toast(message: "내용을 입력해 주세요.", withDuration: 0.5, delay: 1.5, type: "top") {
                    self.simpleWriteView.setCompleteButtonEnable(true)
                }
            } else {
                if self.updateFlag == true {
                    // 수정
                    guard let index = self.selectedIndex else { return }
                    
                    self.parentVC?.viewModel.updateSimpleData(
                        selectedIndex: index,
                        afterContents: contents) { result in
                            if result {
                                self.dismissVC {
                                    self.delegate?.reloadData()
                                }
                            } else {
                                self.showErrorPopup()
                            }
                        }
                } else {
                    // 작성
                    self.parentVC?.viewModel.setSimpleData(contents: contents) { result in
                        if result {
                            self.dismissVC {
                                self.delegate?.reloadData()
                            }
                        } else {
                            self.showErrorPopup()
                        }
                    }
                }
            }
        }
        
        simpleWriteView.cancelButtonTapHandler = {
            self.dismissVC()
        }
        
        simpleWriteView.deleteButtonTapHandler = {
            guard let index = self.selectedIndex else { return }
            
            self.parentVC?.viewModel.deleteSimpleData(selectedIndex: index) { result in
                if result {
                    self.dismissVC {
                        self.delegate?.reloadData()
                    }
                } else {
                    self.showErrorPopup()
                }
            }
        }
    }
}

extension SimpleWriteVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //이전 글자 - 선택된 글자 + 새로운 글자(대체될 글자)
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
            textView.text.removeLast()
        }
    }
}
