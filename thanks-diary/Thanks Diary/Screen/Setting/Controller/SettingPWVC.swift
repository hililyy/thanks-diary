//
//  SettingPWVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/20.
//

import UIKit

final class SettingPWVC: BaseVC {
    
    // MARK: - Property
    
    let settingPWView = SettingPWView()
    var count: Int = 0
    var reEnterFlag: Bool = false
    var homeFlag: Bool = false
    var firstPW: String = ""
    var secondPW: String = ""
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingPWView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if homeFlag == true {
            settingPWView.backButton.isHidden = true
            settingPWView.setContentsLabel(text: "text_password_contents_2".localized)
        } else {
            settingPWView.backButton.isHidden = false
            UserDefaultManager.set("", forKey: UserDefaultKey.PASSWORD)
        }
        
        setTarget()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        settingPWView.numberButtonTapHandler = { [weak self] num in
            guard let self = self else { return }
            
            self.firstPW.append(contentsOf: "\(num)")
            self.count += 1
            self.settingPWView.setDotColor(num: self.count)
            
            if self.count == 4 {
                if self.homeFlag {
                    if self.firstPW == UserDefaultManager.string(forKey: UserDefaultKey.PASSWORD) {
                        self.setMainToRoot()
                    } else {
                        self.handleIncorrectPassword()
                    }
                } else {
                    if self.reEnterFlag {
                        if self.firstPW == self.secondPW {
                            UserDefaultManager.set(self.firstPW, forKey: UserDefaultKey.PASSWORD)
                            UserDefaultManager.set(true, forKey: UserDefaultKey.IS_PASSWORD)
                            self.popVC()
                        } else {
                            self.handleIncorrectPassword()
                        }
                    } else {
                        self.handleReEnterPassword()
                    }
                }
            }
        }
        
        settingPWView.deleteButtonTapHandler = { [weak self] in
            guard let self = self else { return }
            self.count = max(0, self.count - 1)
            _ = self.firstPW.popLast()
            self.settingPWView.setDotColor(num: self.count)
        }
        
        settingPWView.backButtonTapHandler = {
            self.popVC()
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
