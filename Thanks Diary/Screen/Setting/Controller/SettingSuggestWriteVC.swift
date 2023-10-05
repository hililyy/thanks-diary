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
        initTarget()
    }
    
    // MARK: - Function
    
    private func initTarget() {
        settingSuggestWriteView.backgroundButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                dismissVC()
            })
            .disposed(by: disposeBag)
        
        settingSuggestWriteView.completeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                guard let contents = settingSuggestWriteView.contentsTextView.text else { return }
                
                if contents.isEmpty {
                    showToast()
                } else {
                    dismissVC {
                        self.viewModel?.setSuggestData(contents: contents)
                        self.viewModel?.getSuggestDatas()
                    }
                }
            })
            .disposed(by: disposeBag)
        
        settingSuggestWriteView.mailButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                sendEmail()
            })
            .disposed(by: disposeBag)
    }
    
    private func showToast() {
        settingSuggestWriteView.setCompleteButtonEnable(false)
        toast(message: L10n.inputContents, withDuration: 0.5, delay: 1.5, positionType: .top) { [weak self] in
            guard let self else { return }
            settingSuggestWriteView.setCompleteButtonEnable(true)
        }
    }
}
