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
        super.loadView()
        view = simpleWriteView
    }
    
    override func viewDidLoad() {
        initUI()
        initTarget()
    }
    
    // MARK: - Function
    
    private func getDiaryData() -> DiaryModel {
        return DiaryModel(
            type: .simple,
            title: "",
            contents: simpleWriteView.getContentsTextViewText(),
            date: viewModel?.selectedDate.value.convertString() ?? Date().convertString()
        )
    }
    
    private func complete() {
        guard !simpleWriteView.isEmptyTextField() else {
            showFillTextFieldToastAndDisableCompleteButton()
            return
        }
        
        let newData = getDiaryData()
        if let safeBeforeData = beforeData {
            update(beforeData: safeBeforeData, newData: newData)
        } else {
            write(newData)
        }
    }
    
    private func update(beforeData: DiaryModel, newData: DiaryModel) {
        viewModel?.updateData(beforeData: beforeData, newData: newData) { [weak self] result in
            guard let self else { return }
            if result {
                dismissVC {
                    self.viewModel?.readData()
                }
            } else {
                showErrorPopup()
            }
        }
    }
    
    private func write(_ newData: DiaryModel) {
        viewModel?.createData(newData: newData) { [weak self] result in
            guard let self else { return }
            if result {
                dismissVC {
                    self.viewModel?.readData()
                }
            } else {
                showErrorPopup()
            }
        }
    }
    
    private func delete() {
        guard let deleteData = beforeData else { return }
        
        viewModel?.deleteData(deleteData: deleteData) { [weak self] result in
            guard let self else { return }
            if result {
                dismissVC {
                    self.viewModel?.readData()
                }
            } else {
                showErrorPopup()
            }
        }
    }
    
    private func showFillTextFieldToastAndDisableCompleteButton() {
        simpleWriteView.setCompleteButtonEnable(false)
        toast(message: L10n.inputContents, withDuration: 0.5, delay: 1.5, positionType: .top) { [weak self] in
            guard let self else { return }
            simpleWriteView.setCompleteButtonEnable(true)
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
            .drive(onNext: {[weak self] _ in
                guard let self else { return }
                complete()
            })
            .disposed(by: disposeBag)
    }
    
    private func initCancelButtonTarget() {
        simpleWriteView.cancelButton.rx.tap
            .asDriver()
            .drive(onNext: {[weak self] _ in
                guard let self else { return }
                dismissVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initDeleteButtonTarget() {
        simpleWriteView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: {[weak self] _ in
                guard let self else { return }
                delete()
            })
            .disposed(by: disposeBag)
    }
    
    private func initDelegate() {
        simpleWriteView.contentsTextView.delegate = self
    }
}
