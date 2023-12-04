//
//  DetailWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/21.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailWriteVC: BaseVC<DetailWriteView> {
    
    // MARK: - Property
    
    var viewModel: MainViewModel?
    var beforeData: DiaryModel?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        focusTitleTextViewKeyboard()
    }
    
    // MARK: - Function
    
    private func complete(handler: @escaping () -> Void) {
        let newData = getWriteData()
        
        Task {
            if let beforeData {
                try await update(safeBeforeData: beforeData,
                                 newData: newData)
                
            } else {
                try await write(newData)
            }
            
            handler()
        }
    }
    
    private func update(safeBeforeData: DiaryModel, newData: DiaryModel) async throws {
        do {
            try await viewModel?.updateData(beforeData: safeBeforeData,
                                            newData: newData)
            beforeData = newData
            
        } catch {
            showErrorPopup()
        }
    }
    
    private func write(_ newData: DiaryModel) async throws {
        do {
            try await viewModel?.createData(newData: newData)
            beforeData = newData
            
        } catch {
            showErrorPopup()
        }
    }
    
    private func delete() async throws {
        guard let deleteData = beforeData else { return }
        
        do {
            try await viewModel?.deleteData(deleteData: deleteData)
            popVC()
            
        } catch {
            showErrorPopup()
        }
    }
    
    private func save(isBack: Bool) {
        if attachedView.isEmptyTextField() {
            showFillTextFieldToastAndDisEnableCompleteButton()
        } else {
            complete { [weak self] in
                guard let self else { return }
                
                if isBack {
                    self.attachedView.removeNotification()
                    self.popVC()
                } else {
                    attachedView.dropKeyboard()
                    toast(message: L10n.toastCompleteDiary, 
                          withDuration: 0.5,
                          delay: 1.5,
                          positionType: .bottom) {}
                }
            }
        }
    }
    
    private func getWriteData() -> DiaryModel {
        return DiaryModel(
            type: .detail,
            title: attachedView.getTitleText(),
            contents: attachedView.getContentsText(),
            date: viewModel?.selectedDate.value.convertString() ?? Date().convertString()
        )
    }
    
    private func showFillTextFieldToastAndDisEnableCompleteButton() {
        attachedView.setCompleteButtonEnable(isOn: false)
        
        toast(message: L10n.toast, withDuration: 0.5, delay: 1.5) { [weak self] in
            guard let self else { return }
            
            attachedView.setCompleteButtonEnable(isOn: true)
        }
    }
    
    private func focusTitleTextViewKeyboard() {
        if beforeData == nil {
            attachedView.focusTitleTextView()
        }
    }
}

// MARK: - initalize

extension DetailWriteVC {
    private func initalize() {
        initUI()
        initTarget()
    }
    
    private func initUI() {
        attachedView.setTopLabelData(date: viewModel?.selectedDate.value)
        
        if let beforeData {
            attachedView.setTextFieldData(
                titleText: beforeData.title,
                contentsText: beforeData.contents)
        }
    }
    
    private func initTarget() {
        initBackButtonTarget()
        initCompleteButtonTarget()
        initDeleteButtonTarget()
        initKeyBoardWillShowHandler()
        initKeyBoardWillHideHandler()
    }
    
    private func initBackButtonTarget() {
        attachedView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                if attachedView.isEmptyTextField() {
                    showFillTextFieldToastAndDisEnableCompleteButton()
                    attachedView.focusTitleTextViewOrContentsTextView()
                } else {
                    save(isBack: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func initCompleteButtonTarget() {
        attachedView.completeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                if attachedView.isEmptyTextField() {
                    showFillTextFieldToastAndDisEnableCompleteButton()
                    attachedView.focusTitleTextViewOrContentsTextView()
                } else {
                    save(isBack: false)
                    attachedView.dropKeyboard()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func initDeleteButtonTarget() {
        attachedView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                presentDeleteAlertVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initKeyBoardWillShowHandler() {
        attachedView.keyBoardWillShowHandler = { [weak self] in
            guard let self else { return }
            
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    private func initKeyBoardWillHideHandler() {
        attachedView.keyBoardWillHideHandler = { [weak self] in
            guard let self else { return }
            
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
}

// MARK: - View Change

extension DetailWriteVC {
    private func presentDeleteAlertVC() {
        let vc = AlertVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.rightButtonTapHandler = { [weak self] in
            guard let self else { return }
            
            Task {
                try await self.delete()
            }
        }
        
        present(vc, animated: true)
    }
}
