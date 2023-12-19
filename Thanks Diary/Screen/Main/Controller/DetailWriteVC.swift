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
    
    var viewModel: MainViewModel
    var beforeData: DiaryModel?
    
    // MARK: - Init
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            try await viewModel.updateData(beforeData: safeBeforeData,
                                            newData: newData)
            beforeData = newData
            
        } catch {
            showErrorPopup()
        }
    }
    
    private func write(_ newData: DiaryModel) async throws {
        do {
            try await viewModel.createData(newData: newData)
            beforeData = newData
            
        } catch {
            showErrorPopup()
        }
    }
    
    private func delete() async throws {
        guard let deleteData = beforeData else { return }
        
        do {
            try await viewModel.deleteData(deleteData: deleteData)
            popVC()
            
        } catch {
            showErrorPopup()
        }
    }
    
    private func save(isBack: Bool) {
        complete { [weak self] in
            guard let self else { return }
            
            if isBack {
                attachedView.removeNotification()
                popVC()
            } else {
                attachedView.dropKeyboard()
                toast(message: L10n.toastCompleteDiary,
                      withDuration: 0.5,
                      delay: 1.5,
                      positionType: .bottom) {}
            }
        }
    }
    
    private func getWriteData() -> DiaryModel {
        return DiaryModel(
            type: .detail,
            title: attachedView.getTitleText(),
            contents: attachedView.getContentsText(),
            date: viewModel.selectedDate.value.convertString()
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
        attachedView.setTopLabelData(date: viewModel.selectedDate.value)
        
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
                
                let tfType = attachedView.getEmptyTextFieldType()
                
                switch tfType {
                case .allEmpty:
                    
                    guard beforeData != nil else {
                        attachedView.removeNotification()
                        popVC()
                        
                        return
                    }
                    
                    Task {
                        try await self.delete()
                        self.attachedView.removeNotification()
                        self.popVC()
                    }
                    
                case .eitherEmpty:
                    showFillTextFieldToastAndDisEnableCompleteButton()
                    attachedView.focusTitleTextViewOrContentsTextView()
                    
                case .notAllEmpty:
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
                
                let tfType = attachedView.getEmptyTextFieldType()
                
                if tfType == .eitherEmpty {
                    showFillTextFieldToastAndDisEnableCompleteButton()
                    attachedView.focusTitleTextViewOrContentsTextView()
                } else {
                    save(isBack: false)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func initDeleteButtonTarget() {
        attachedView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                presentDeleteAlertPopup()
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
    private func presentDeleteAlertPopup() {
        DispatchQueue.main.async {
            self.showAlert(message: L10n.alertDelete,
                      leftButtonText: L10n.cancel,
                      rightButtonText: L10n.delete,
                      leftButtonHandler: {},
                      rightButtonHandler: { [weak self] in
                guard let self else { return }
                
                Task {
                    try await self.delete()
                }
            })
        }
    }
}
