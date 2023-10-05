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
    private let maxCount: Int = 50
    var beforeData: DiaryModel?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = simpleWriteView
    }
    
    override func viewDidLoad() {
        initUI()
        initTarget()
    }
    
    // MARK: - Function
    
    private func complete() {
        let newData = DiaryModel(
            type: .simple,
            title: "",
            contents: self.simpleWriteView.getContentsTextViewText(),
            date: self.viewModel?.selectedDate.value.convertString() ?? Date().convertString()
        )
        
        if self.simpleWriteView.isEmptyTextField() {
            self.showFillTextFieldToastAndDisEnableCompleteButton()
        } else {
            if let beforeData = self.beforeData {
                self.update(beforeData: beforeData, newData: newData)
            } else {
                self.write(newData)
            }
        }
    }
    
    private func update(beforeData: DiaryModel, newData: DiaryModel) {
        self.viewModel?.updateData(beforeData: beforeData, newData: newData) { [weak self] result in
            guard let self else { return }
            if result {
                self.dismissVC {
                    self.viewModel?.readData()
                }
            } else {
                self.showErrorPopup()
            }
        }
    }
    
    private func write(_ newData: DiaryModel) {
        self.viewModel?.createData(newData: newData) { [weak self] result in
            guard let self else { return }
            if result {
                self.dismissVC {
                    self.viewModel?.readData()
                }
            } else {
                self.showErrorPopup()
            }
        }
    }
    
    private func delete() {
        guard let deleteData = beforeData else { return }
        
        self.viewModel?.deleteData(deleteData: deleteData) { [weak self] result in
            guard let self else { return }
            if result {
                self.dismissVC {
                    self.viewModel?.readData()
                }
            } else {
                self.showErrorPopup()
            }
        }
    }
    
    private func showFillTextFieldToastAndDisEnableCompleteButton() {
        self.simpleWriteView.setCompleteButtonEnable(false)
        self.toast(message: L10n.inputContents, withDuration: 0.5, delay: 1.5, positionType: .top) {
            self.simpleWriteView.setCompleteButtonEnable(true)
        }
    }
}

// MARK: - UITextViewDelegate

extension SimpleWriteVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLength = textView.text.count - range.length + text.count
        let koreanMaxCount = maxCount + 1
        
        if newLength > koreanMaxCount {
            let overflow = newLength - koreanMaxCount
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

// MARK: - initalize

extension SimpleWriteVC {
    private func initalize() {
        initDelegate()
        initUI()
        initTarget()
    }
    
    private func initUI() {
        simpleWriteView.maxCount = maxCount
        simpleWriteView.setHiddenForDeleteButton(beforeData == nil)
        
        if let beforeData {
            simpleWriteView.setContentsTextView(text: beforeData.contents)
        }
    }
    
    private func initTarget() {
        initCompleteButtonTarget()
        initCancelButtonTarget()
        initDeleteButtonTarget()
    }
    
    private func initCompleteButtonTarget() {
        simpleWriteView.completeButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.complete()
            })
            .disposed(by: disposeBag)
    }
    
    private func initCancelButtonTarget() {
        simpleWriteView.cancelButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.dismissVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initDeleteButtonTarget() {
        simpleWriteView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.delete()
            })
            .disposed(by: disposeBag)
    }
    
    private func initDelegate() {
        simpleWriteView.contentsTextView.delegate = self
    }
}
