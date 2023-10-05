//
//  SettingPWVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/20.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingPWVC: BaseVC {
    
    // MARK: - Property
    
    let settingPWView = SettingPWView()
    var count: Int = 0
    var reEnterFlag: Bool = false
    var homeFlag: Bool = false
    var firstPW: String = ""
    var secondPW: String = ""
    var maxCount: Int = 4
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingPWView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
        initTarget()
    }
    
    // MARK: - Function
    
    private func initalize() {
        settingPWView.backButton.isHidden = homeFlag
        
        if homeFlag {
            settingPWView.setContentsLabel(text: L10n.passwordContents2)
        } else {
            UserDefaultManager.instance?.set("", key: UserDefaultKey.PASSWORD.rawValue)
        }
    }
    
    private func initTarget() {
        settingPWView.numberButtonTapHandler = { [weak self] num in
            guard let self else { return }
            
            firstPW.append("\(num)")
            count += 1
            settingPWView.setDotColor(num: count)
            
            if count == maxCount {
                if homeFlag {
                    if firstPW == UserDefaultManager.instance?.string(UserDefaultKey.PASSWORD.rawValue) {
                        registMainToRoot()
                    } else {
                        handleIncorrectPassword()
                    }
                } else {
                    if reEnterFlag {
                        if firstPW == secondPW {
                            UserDefaultManager.instance?.set(firstPW, key: UserDefaultKey.PASSWORD.rawValue)
                            UserDefaultManager.instance?.set(true, key: UserDefaultKey.IS_PASSWORD.rawValue)
                            popVC()
                        } else {
                            handleIncorrectPassword()
                        }
                    } else {
                        handleReEnterPassword()
                    }
                }
            }
        }
        
        settingPWView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                count = max(0, count - 1)
                _ = firstPW.popLast()
                settingPWView.setDotColor(num: count)
            })
            .disposed(by: disposeBag)
        
        settingPWView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func handleIncorrectPassword() {
        settingPWView.setDotColor(num: 0)
        settingPWView.setContentsLabel(text: L10n.passwordIncorrect, textColor: Asset.Color.red.color)
        firstPW = ""
        secondPW = ""
        reEnterFlag = false
        count = 0
    }
    
    private func handleReEnterPassword() {
        settingPWView.setDotColor(num: 0)
        settingPWView.setContentsLabel(text: L10n.passwordRetry)
        secondPW = firstPW
        firstPW = ""
        reEnterFlag = true
        count = 0
    }
}
