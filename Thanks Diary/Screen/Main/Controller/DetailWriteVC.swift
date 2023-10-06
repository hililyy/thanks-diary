//
//  DetailWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/21.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailWriteVC: BaseVC {
    
    // MARK: - Property
    
    private var detailWriteView = DetailWriteView()
    var viewModel: MainViewModel?
    var beforeData: DiaryModel?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = detailWriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        focusTitleTextViewKeyboard()
    }
    
    // MARK: - Function
    
    private func complete() {
        let newData = DiaryModel(
            type: .detail,
            title: detailWriteView.getTitleText(),
            contents: detailWriteView.getContentsText(),
            date: viewModel?.selectedDate.value.convertString() ?? Date().convertString()
        )
        
        if let beforeData {
            update(safeBeforeData: beforeData, newData: newData)
        } else {
            write(newData)
        }
    }
    
    private func update(safeBeforeData: DiaryModel, newData: DiaryModel) {
        viewModel?.updateData(beforeData: safeBeforeData, newData: newData) { [weak self] result in
            guard let self else { return }
            if result {
                beforeData = newData
            } else {
                showErrorPopup()
            }
        }
    }
    
    private func write(_ newData: DiaryModel) {
        viewModel?.createData(newData: newData) { [weak self] result in
            guard let self else { return }
            if result {
                beforeData = newData
            } else {
                showErrorPopup()
            }
        }
    }
    
    private func showFillTextFieldToastAndDisEnableCompleteButton() {
        detailWriteView.setCompleteButtonEnable(isOn: false)
        toast(message: L10n.toast, withDuration: 0.5, delay: 1.5) { [weak self] in
            guard let self else { return }
            detailWriteView.setCompleteButtonEnable(isOn: true)
        }
    }
    
    private func focusTitleTextViewKeyboard() {
        if beforeData == nil {
            detailWriteView.focusTitleTextView()
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
        detailWriteView.setTopLabelData(date: viewModel?.selectedDate.value)
        
        if let beforeData {
            detailWriteView.setTextFieldData(
                titleText: beforeData.title,
                contentsText: beforeData.contents)
        }
    }
    
    private func initTarget() {
        initBackButtonTarget()
        initCompleteButtonTarget()
        initDeleteButtonTarget()
        initCompleteHandler()
        initKeyBoardWillShowHandler()
        initKeyBoardWillHideHandler()
    }
    
    private func initBackButtonTarget() {
        detailWriteView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                detailWriteView.removeNotification()
                popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initCompleteButtonTarget() {
        detailWriteView.completeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                if detailWriteView.isEmptyTextField() {
                    showFillTextFieldToastAndDisEnableCompleteButton()
                    detailWriteView.focusTitleTextViewOrContentsTextView()
                } else {
                    detailWriteView.dropKeyboard()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func initDeleteButtonTarget() {
        detailWriteView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                presentDeleteAlertVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initCompleteHandler() {
        detailWriteView.completeHandler = { [weak self] in
            guard let self else { return }
            if detailWriteView.isEmptyTextField() {
                showFillTextFieldToastAndDisEnableCompleteButton()
            } else {
                complete()
            }
        }
    }
    
    private func initKeyBoardWillShowHandler() {
        detailWriteView.keyBoardWillShowHandler = { [weak self] in
            guard let self else { return }
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    private func initKeyBoardWillHideHandler() {
        detailWriteView.keyBoardWillHideHandler = { [weak self] in
            guard let self else { return }
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
}

// MARK: - View Change

extension DetailWriteVC {
    private func presentDeleteAlertVC() {
        guard let deleteData = beforeData else { return }
        
        let vc = AlertVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.rightButtonTapHandler = { [weak self] in
            guard let self else { return }
            viewModel?.deleteData(deleteData: deleteData) { result in
                self.popVC()
                if !result {
                    self.showErrorPopup()
                }
            }
        }
        present(vc, animated: true)
    }
}
