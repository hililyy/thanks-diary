//
//  DetailWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/21.
//

import UIKit

final class DetailWriteVC: BaseVC {
    
    // MARK: - Property
    
    var updateFlag: Bool = false
    var viewModel: MainViewModel?
    var selectedIndex: Int?
    let detailWriteView = DetailWriteView()
    
    // MARK:- Life Cycle
    
    override func loadView() {
        view = detailWriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTarget()
        
        detailWriteView.titleTextField.delegate = self
    }
    
    // MARK: - Function
    
    private func configureUI() {
        detailWriteView.setTopLabelData(date: viewModel?.selectedDate)
        
        if updateFlag == true {
            guard let index = selectedIndex,
                  let titleText = viewModel?.selectedDetailData[index].title,
                  let contentsText = viewModel?.selectedDetailData[index].contents else { return }
            
            detailWriteView.setTextFieldData(titleText: titleText,
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
        if detailWriteView.isEmptyTextField() {
            detailWriteView.setCompleteButtonEnable(isOn: false)
            toast(message: "text_toast".localized, withDuration: 0.5, delay: 1.5) {
                self.detailWriteView.setCompleteButtonEnable(isOn: true)
            }
            
        } else {
            if updateFlag == true {
                // 수정
                guard let index = selectedIndex else { return }
                
                viewModel?.updateDetailData(
                    selectedIndex: index,
                    afterTitle: detailWriteView.getTitleText(),
                    afterContents: detailWriteView.getContentsText()) { result in
                        if result {
                            self.viewModel?.getAllDiaryData {
                                self.viewModel?.getSelectedDiaryData {
                                    self.popVC()
                                }
                            }
                        } else {
                            self.showErrorPopup()
                        }
                    }
            } else {
                
                // 글 작성
                viewModel?.setDetailData(
                    title: detailWriteView.getTitleText(),
                    contents: detailWriteView.getContentsText()) { result in
                        if result {
                            self.popVC()
                        } else {
                            self.showErrorPopup()
                        }
                    }
            }
        }
    }
}

extension DetailWriteVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count ?? 0) + string.count - range.length
        return newLength <= 20
    }
}
