//
//  SettingSuggestWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingSuggestWriteVC: BaseVC {
    
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
                guard let contents = self.settingSuggestWriteView.contentsTextView.text else { return }
                
                if contents.isEmpty {
                    self.showToast()
                } else {
                    self.dismissVC {
                        self.viewModel?.setSuggestData(contents: contents)
                        self.viewModel?.getSuggestDatas()
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
        self.toast(message: "text_input_contents".localized, withDuration: 0.5, delay: 1.5, positionType: .top) {
            self.settingSuggestWriteView.setCompleteButtonEnable(true)
        }
    }
}
