//
//  SettingSuggestWriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingSuggestWriteVC: BaseVC<SettingSuggestWriteView> {
    
    // MARK: - Property
    
    var viewModel: SettingViewModel?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
    }
    
    // MARK: - Function
    
    private func complete() {
        guard let contents = attachedView.contentsTextView.text else { return }
        
        if contents.isEmpty {
            showToast()
        } else {
            dismissVC {
                self.viewModel?.setSuggestData(contents: contents)
                self.viewModel?.getSuggestDatas()
            }
        }
    }
    
    private func showToast() {
        attachedView.setCompleteButtonEnable(false)
        toast(message: L10n.inputContents,
              withDuration: 0.5,
              delay: 1.5,
              positionType: .top) { [weak self] in
            guard let self else { return }
            
            attachedView.setCompleteButtonEnable(true)
        }
    }
}

// MARK: - initalize

extension SettingSuggestWriteVC {
    private func initalize() {
        initTarget()
    }
    
    private func initTarget() {
        initBackgrounButtonTarget()
        initCompleteButtonTarget()
        initMailButtonTarget()
    }
    
    private func initBackgrounButtonTarget() {
        attachedView.backgroundButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                dismissVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initCompleteButtonTarget() {
        attachedView.completeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                complete()
            })
            .disposed(by: disposeBag)
    }
    
    private func initMailButtonTarget() {
        attachedView.mailButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                sendEmail()
            })
            .disposed(by: disposeBag)
    }
}
