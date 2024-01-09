//
//  SimpleWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/05.
//

import UIKit
import RxSwift
import RxCocoa

final class SimpleWriteVC: BaseVC<SimpleWriteView> {
    
    // MARK: - Property
    
    var viewModel: MainViewModel
    private let maxCount: Int = 50
    var beforeData: DiaryModel?
    
    // MARK: - Init
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
    }
    
    // MARK: - Function
    
    private func getDiaryData() -> DiaryModel {
        return DiaryModel(
            type: .simple,
            title: "",
            contents: attachedView.getContentsTextViewText(),
            date: viewModel.selectedDate.value.toString(didChangeDateFormat: Constant.YYYYMD) 
        )
    }
    
    private func complete() {
        if attachedView.isEmptyTextField() {
            showFillTextFieldToastAndDisableCompleteButton()
            return
        }
        
        let newData = getDiaryData()
        
        Task {
            if let safeBeforeData = beforeData {
                try await update(beforeData: safeBeforeData,
                                 newData: newData)
                
            } else {
                try await write(newData)
            }
        }
    }
    
    private func update(beforeData: DiaryModel, newData: DiaryModel) async throws {
        do {
            try await viewModel.updateData(beforeData: beforeData,
                                           newData: newData)
            dismissVC {
                self.viewModel.readData()
            }
        } catch {
            showErrorPopup()
        }
    }
    
    private func write(_ newData: DiaryModel) async throws {
        do {
            try await viewModel.createData(newData: newData)
            dismissVC {
                self.viewModel.readData()
            }
        } catch {
            showErrorPopup()
        }
    }
    
    private func delete() async throws {
        guard let deleteData = beforeData else { return }
        
        do {
            try await viewModel.deleteData(deleteData: deleteData)
            dismissVC {
                self.viewModel.readData()
            }
        } catch {
            showErrorPopup()
        }
    }
    
    private func showFillTextFieldToastAndDisableCompleteButton() {
        attachedView.setCompleteButtonEnable(false)
        
        toast(message: L10n.inputContents,
              withDuration: 0.5,
              delay: 1.5,
              positionType: .top) { [weak self] in
            guard let self else { return }
            
            attachedView.setCompleteButtonEnable(true)
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
            
            guard let startPosition = textView.position(from: textView.beginningOfDocument,
                                                        offset: range.location),
                  let endPosition = textView.position(from: textView.beginningOfDocument, 
                                                      offset: NSMaxRange(range)),
                  let textRange = textView.textRange(from: startPosition, 
                                                     to: endPosition) else { return false }
            
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
        attachedView.maxCount = maxCount
        attachedView.setHiddenForDeleteButton(beforeData == nil)
        
        if let beforeData {
            attachedView.setContentsTextView(text: beforeData.contents)
        }
    }
    
    private func initTarget() {
        initCompleteButtonTarget()
        initCancelButtonTarget()
        initDeleteButtonTarget()
    }
    
    private func initCompleteButtonTarget() {
        attachedView.completeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                
                complete()
            })
            .disposed(by: disposeBag)
    }
    
    private func initCancelButtonTarget() {
        attachedView.backgroundButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                
                dismissVC()
            })
            .disposed(by: disposeBag)
        
        attachedView.cancelButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                
                dismissVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initDeleteButtonTarget() {
        attachedView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                
                Task {
                    try await self.delete()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func initDelegate() {
        attachedView.contentsTextView.delegate = self
    }
}
