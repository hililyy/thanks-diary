//
//  SettingSuggestWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import UIKit
import RxSwift
import RxCocoa

class SettingSuggestWriteVC: BaseVC {
    
    // MARK: - Property
    
    let settingSuggestWriteView = SettingSuggestWriteView()
    var viewModel: SettingViewModel?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingSuggestWriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        settingSuggestWriteView.backgroundButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.dismissVC()
            })
            .disposed(by: disposeBag)
        
        settingSuggestWriteView.completeButton.rx.tap
            .asDriver()
            .drive(onNext: {
                if let contents = self.settingSuggestWriteView.contentsTextView.text,
                   contents.isEmpty
                {
                    self.showToast()
                } else {
                    self.dismissVC {
                        self.viewModel?.setSuggestData(contents: self.settingSuggestWriteView.contentsTextView.text)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        settingSuggestWriteView.mailButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.sendEmail()
            })
            .disposed(by: disposeBag)
    }
    
    private func showToast() {
        self.settingSuggestWriteView.setCompleteButtonEnable(false)
        self.toast(message: "내용을 입력해 주세요.", withDuration: 0.5, delay: 1.5, type: "top") {
            self.settingSuggestWriteView.setCompleteButtonEnable(true)
        }
    }
}
