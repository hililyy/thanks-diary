//
//  SettingPWVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/20.
//

import UIKit

final class SettingPWVC: BaseVC {
    
    // MARK: - Property
    
    var count: Int = 0
    var reEnterFlag: Bool = false
    var homeFlag: Bool = false
    var firstPW: String = ""
    var secondPW: String = ""
    let settingPWView = SettingPWView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingPWView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if homeFlag == true {
            settingPWView.setContentsLabel(text: "text_password_contents_2".localized)
        }
        
        setTarget()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        settingPWView.numberButtonTapHandler = { [weak self] num in
            guard let self = self else { return }
            
            firstPW.append(contentsOf: "\(num)")
            count += 1
            settingPWView.setDotColor(num: count)
            
            if count == 4 {
                if homeFlag {
                    if firstPW == UserDefaultManager.string(forKey: UserDefaultKey.PASSWORD) {
                        setMainToRoot()
                    } else {
                        handleIncorrectPassword()
                    }
                } else {
                    if reEnterFlag {
                        if firstPW == secondPW {
                            UserDefaultManager.set(firstPW, forKey: UserDefaultKey.PASSWORD)
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
        
        settingPWView.deleteButtonTapHandler = { [weak self] in
            guard let self = self else { return }
            count = max(0, count - 1)
            firstPW.popLast()
            settingPWView.setDotColor(num: count)
        }
    }
    
    private func handleIncorrectPassword() {
        settingPWView.setDotColor(num: 0)
        settingPWView.setContentsLabel(text: "text_password_incorrect".localized, textColor: Color.COLOR_RED ?? .red)
        firstPW = ""
        secondPW = ""
        reEnterFlag = false
        count = 0
    }
    
    private func handleReEnterPassword() {
        settingPWView.setDotColor(num: 0)
        settingPWView.setContentsLabel(text: "text_password_retry".localized)
        secondPW = firstPW
        firstPW = ""
        reEnterFlag = true
        count = 0
    }
}
