//
//  DetailWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/21.
//

import UIKit

final class DetailWriteVC: BaseVC {
    
    var updateFlag: Bool = false
    var parentVC: MainVC?
    var selectedIndex: Int?
    let detailWriteView = DetailWriteView()
    
    override func loadView() {
        view = detailWriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTarget()
    }

    private func configureUI() {
        detailWriteView.setTopLabelData(date: parentVC?.viewModel.selectedDate)
        
        if updateFlag == true {
            guard let index = selectedIndex,
                  let titleText = parentVC?.viewModel.selectedDetailData[index].title,
                  let contentsText = parentVC?.viewModel.selectedDetailData[index].contents else { return }
            
            detailWriteView.setTextFieldData(titleText: titleText,
                                             contentsText: contentsText)
        }
    }
    
    private func setTarget() {
        detailWriteView.backButton.addTarget {
            self.popVC()
        }
        
        detailWriteView.completeButton.addTarget {
            self.complete()
        }
    }
    
    private func complete() {
        if detailWriteView.isEmptyTextField() {
            detailWriteView.setCompleteButtonEnable(isOn: false)
            toast(message: "제목과 내용을 모두 입력해 주세요.", withDuration: 0.5, delay: 1.5) {
                self.detailWriteView.setCompleteButtonEnable(isOn: true)
            }
            
        } else {
            if updateFlag == true {
                // 수정
                guard let index = selectedIndex else { return }
                
                parentVC?.viewModel.updateDetailData(
                    selectedIndex: index,
                    afterTitle: detailWriteView.getTitleText(),
                    afterContents: detailWriteView.getContentsText()) { result in
                        if result {
                            self.parentVC?.viewModel.getAllDiaryData {
                                self.parentVC?.viewModel.getSelectedDiaryData {
                                    self.popVC()
                                }
                            }
                        } else {
                            print("error")
                        }
                    }
            } else {
                
                // 글 작성
                parentVC?.viewModel.setDetailData(
                    title: detailWriteView.getTitleText(),
                    contents: detailWriteView.getContentsText()) { result in
                        if result {
                            self.popVC()
                        } else {
                            print("error")
                        }
                    }
            }
        }
    }
}
