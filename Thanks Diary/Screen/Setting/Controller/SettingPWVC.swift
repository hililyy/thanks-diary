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
        super.loadView()
        view = settingPWView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    // MARK: - Function
    
    private func initNumberButtonTapHandler(_ num: Int) {
        firstPW.append("\(num)")
        count += 1
        settingPWView.setDotColor(num: count)
        
        if isLastInput() {
            if homeFlag {
                handleFromHome()
            } else {
                handleFromSetting()
            }
        }
    }
    
    private func isLastInput() -> Bool {
        return count == maxCount
    }
    
    private func handleFromHome() {
        let oldPassword = UserDefaultManager.instance?.string(UserDefaultKey.PASSWORD.rawValue)
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
            UserDefaultManager.instance?.set(firstPW, key: UserDefaultKey.PASSWORD.rawValue)
            UserDefaultManager.instance?.set(true, key: UserDefaultKey.IS_PASSWORD.rawValue)
            popVC()
        } else {
            handleIncorrectPassword()
        }
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

// MARK: - initalize

extension SettingPWVC {
    private func initalize() {
        initUI()
        initTarget()
    }
    
    private func initUI() {
        settingPWView.backButton.isHidden = homeFlag
        
        if homeFlag {
            settingPWView.setContentsLabel(text: L10n.passwordContents2)
        } else {
            UserDefaultManager.instance?.set("", key: UserDefaultKey.PASSWORD.rawValue)
        }
    }
    
    private func initTarget() {
        initNumberButtonTapHander()
        initDeleteButtonTarget()
        initBackButtonTarget()
    }
    
    private func initNumberButtonTapHander() {
        settingPWView.numberButtonTapHandler = { [weak self] num in
            guard let self else { return }
            initNumberButtonTapHandler(num)
        }
    }
    
    private func initDeleteButtonTarget() {
        settingPWView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                count = max(0, count - 1)
                _ = firstPW.popLast()
                settingPWView.setDotColor(num: count)
            })
            .disposed(by: disposeBag)
    }
    
    private func initBackButtonTarget() {
        settingPWView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                popVC()
            })
            .disposed(by: disposeBag)
    }
}
