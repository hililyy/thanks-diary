//
//  SimpleWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/05.
//

import UIKit
import RxSwift
import RxCocoa

final class SimpleWriteVC: BaseVC {
    
    // MARK: - Property
    
    private let simpleWriteView = SimpleWriteView()
    var viewModel: MainViewModel?
    let maxCount: Int = 22
    
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
        
        simpleWriteView.setHiddenForDeleteButton(viewModel?.selectedDiaryData == nil)
        
        if let beforeData = viewModel?.selectedDiaryData {
            guard let text = beforeData.contents else { return }
            simpleWriteView.setContentsTextView(text: text)
        }
    }
    
    private func setTarget() {
        simpleWriteView.completeButton.rx.tap
            .asDriver()
            .drive(onNext: {
                let newData = DiaryModel(
                    type: .simple,
                    title: "",
                    contents: self.simpleWriteView.getContentsTextViewText(),
                    date: self.viewModel?.selectedDate.value.convertString()
                )
                
                if let contents = newData.contents,
                   contents.isEmpty {
                    // 텍스트 뷰가 비어있으면 토스트 띄움
                    self.showToast()
                } else {
                    if let _ = self.viewModel?.selectedDiaryData {
                        self.updateDiary(newData)
                    } else {
                        self.writeDiary(newData)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        simpleWriteView.cancelButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.dismissVC()
            })
            .disposed(by: disposeBag)
        
        simpleWriteView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.deleteDiary()
            })
            .disposed(by: disposeBag)
    }
    
    private func updateDiary(_ newData: DiaryModel) {
        self.viewModel?.updateData(newData: newData) { result in
            if result {
                self.dismissVC {
                    self.viewModel?.getData()
                }
            } else {
                self.showErrorPopup()
            }
        }
    }
    
    private func writeDiary(_ newData: DiaryModel) {
        self.viewModel?.setData(newData: newData) { result in
            if result {
                self.dismissVC {
                    self.viewModel?.getData()
                }
            } else {
                self.showErrorPopup()
            }
        }
    }
    
    private func deleteDiary() {
        self.viewModel?.deleteData() { result in
            if result {
                self.dismissVC {
                    self.viewModel?.getData()
                }
            } else {
                self.showErrorPopup()
            }
        }
    }
    
    private func showToast() {
        self.simpleWriteView.setCompleteButtonEnable(false)
        self.toast(message: "내용을 입력해 주세요.", withDuration: 0.5, delay: 1.5, type: "top") {
            self.simpleWriteView.setCompleteButtonEnable(true)
        }
    }
}

// MARK: - UITextViewDelegate

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
                  let textRange = textView.textRange(from: startPosition, to: endPosition) else { return false }
            
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
