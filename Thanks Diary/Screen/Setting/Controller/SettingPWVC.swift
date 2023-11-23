//
//  SettingPWVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/20.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingPWVC: BaseVC<SettingPWView> {
    
    // MARK: - Property
    
    var count: Int = 0
    var reEnterFlag: Bool = false
    var homeFlag: Bool = false
    var firstPW: String = ""
    var secondPW: String = ""
    var maxCount: Int = 4
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
    }
    
    // MARK: - Function
    
    private func initNumberButtonTapHandler(_ num: Int) {
        firstPW.append("\(num)")
        count += 1
        
        attachedView.setDotColor(num: count)
        
        if count != maxCount { return }
        
        if homeFlag {
            handleFromHome()
        } else {
            handleFromSetting()
        }
    }
    
    private func handleFromHome() {
        let oldPassword = UserDefaultManager.instance.password
        
        if firstPW == oldPassword {
            registMainToRoot()
        } else {
            handleIncorrectPassword()
        }
    }
    
    private func handleFromSetting() {
        if reEnterFlag {
            handleReEnter()
        } else {
            handleReEnterPassword()
        }
    }
    
    private func handleReEnter() {
        if firstPW == secondPW {
            UserDefaultManager.instance.password = firstPW
            UserDefaultManager.instance.isPassword = true
            popVC()
        } else {
            handleIncorrectPassword()
        }
    }
    
    private func handleIncorrectPassword() {
        attachedView.setDotColor(num: 0)
        attachedView.setContentsLabel(text: L10n.passwordIncorrect, 
                                      textColor: Asset.Color.red.color)
        firstPW = ""
        secondPW = ""
        reEnterFlag = false
        count = 0
    }
    
    private func handleReEnterPassword() {
        attachedView.setDotColor(num: 0)
        attachedView.setContentsLabel(text: L10n.passwordRetry)
        secondPW = firstPW
        firstPW = ""
        reEnterFlag = true
        count = 0
    }
}

// MARK: - initalize

extension SettingPWVC {
    private func initalize() {
        initUI()
        initTarget()
    }
    
    private func initUI() {
        attachedView.backButton.isHidden = homeFlag
        
        if homeFlag {
            attachedView.setContentsLabel(text: L10n.passwordContents2)
        } else {
            UserDefaultManager.instance.password = ""
        }
    }
    
    private func initTarget() {
        initNumberButtonTapHander()
        initDeleteButtonTarget()
        initBackButtonTarget()
    }
    
    private func initNumberButtonTapHander() {
        attachedView.numberButtonTapHandler = { [weak self] num in
            guard let self else { return }
            
            initNumberButtonTapHandler(num)
        }
    }
    
    private func initDeleteButtonTarget() {
        attachedView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                count = max(0, count - 1)
                _ = firstPW.popLast()
                attachedView.setDotColor(num: count)
            })
            .disposed(by: disposeBag)
    }
    
    private func initBackButtonTarget() {
        attachedView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                popVC()
            })
            .disposed(by: disposeBag)
    }
}
