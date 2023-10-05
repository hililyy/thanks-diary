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
    
    private let detailWriteView = DetailWriteView()
    var viewModel: MainViewModel?
    var beforeData: DiaryModel?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = detailWriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
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
            self.update(beforeData: beforeData, newData: newData)
        } else {
            self.write(newData)
        }
    }
    
    private func update(beforeData: DiaryModel, newData: DiaryModel) {
        viewModel?.updateData(beforeData: beforeData, newData: newData) { [weak self] result in
            guard let self else { return }
            if result {
                self.beforeData = newData
            } else {
                self.showErrorPopup()
            }
        }
    }
    
    private func write(_ newData: DiaryModel) {
        viewModel?.createData(newData: newData) { [weak self] result in
            guard let self else { return }
            if result {
                self.beforeData = newData
            } else {
                self.showErrorPopup()
            }
        }
    }
    
    private func showFillTextFieldToastAndDisEnableCompleteButton() {
        detailWriteView.setCompleteButtonEnable(isOn: false)
        toast(message: L10n.toast, withDuration: 0.5, delay: 1.5) {
            self.detailWriteView.setCompleteButtonEnable(isOn: true)
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
        } else {
            detailWriteView.focusTitleTextViewKeyboard()
        }
    }
    
    private func initTarget() {
        initBackButtonTarget()
        initCompleteButtonTarget()
        initDeleteButtonTarget()
        initCompleteHandler()
    }
    
    private func initBackButtonTarget() {
        detailWriteView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                self.popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initCompleteButtonTarget() {
        detailWriteView.completeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                if self.detailWriteView.isEmptyTextField() {
                    self.showFillTextFieldToastAndDisEnableCompleteButton()
                } else {
                    self.view.endEditing(true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func initDeleteButtonTarget() {
        detailWriteView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                self.presentDeleteAlertVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initCompleteHandler() {
        detailWriteView.completeHandler = { [weak self] in
            guard let self else { return }
            if self.detailWriteView.isEmptyTextField() {
                self.showFillTextFieldToastAndDisEnableCompleteButton()
            } else {
                self.complete()
            }
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
            self.viewModel?.deleteData(deleteData: deleteData) { result in
                self.popVC()
                if !result {
                    self.showErrorPopup()
                }
            }
        }
        present(vc, animated: true)
    }
}
