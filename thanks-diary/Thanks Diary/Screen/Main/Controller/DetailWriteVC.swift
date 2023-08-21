//
//  DetailWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/21.
//

import UIKit

final class DetailWriteVC: BaseVC {
    
    // MARK: - Property
    
    private let detailWriteView = DetailWriteView()
    var viewModel: MainViewModel?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = detailWriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTarget()
    }
    
    // MARK: - Function
    
    private func configureUI() {
        detailWriteView.setTopLabelData(date: viewModel?.selectedDate.value)
        
        if let beforeData = viewModel?.selectedDiaryData {
            guard let titleText = beforeData.title,
                  let contentsText = beforeData.contents else { return }
            
            detailWriteView.setTextFieldData(
                titleText: titleText,
                contentsText: contentsText)
        }
    }
    
    private func setTarget() {
        detailWriteView.backButtonTapHandler = {
            self.popVC()
        }
        
        detailWriteView.completeButtonTapHandler = {
            self.complete()
        }
    }
    
    private func complete() {
        let newData = DiaryModel(
            type: .detail,
            title: detailWriteView.getTitleText(),
            contents: detailWriteView.getContentsText(),
            date: viewModel?.selectedDate.value.convertString()
        )
        
        if detailWriteView.isEmptyTextField() {
            detailWriteView.setCompleteButtonEnable(isOn: false)
            toast(message: "text_toast".localized, withDuration: 0.5, delay: 1.5) {
                self.detailWriteView.setCompleteButtonEnable(isOn: true)
            }
            
        } else {
            if let _ = viewModel?.selectedDiaryData {
                // 수정
                viewModel?.updateData(newData: newData) { result in
                    if result {
                        self.viewModel?.selectedDiaryData = newData
                        self.viewModel?.getData()
                        self.popVC()
                    } else {
                        self.showErrorPopup()
                    }
                }
            } else {
                // 글 작성
                viewModel?.setData(newData: newData) { result in
                    if result {
                        self.popVC()
                        self.viewModel?.getData()
                    } else {
                        self.showErrorPopup()
                    }
                }
            }
        }
    }
}
