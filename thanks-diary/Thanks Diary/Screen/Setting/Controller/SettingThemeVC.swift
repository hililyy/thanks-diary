//
//  SettingThemeVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/17.
//

import UIKit

final class SettingThemeVC: BaseVC {
    
    // MARK: - Property
    
    private let settingThemeView = SettingThemeView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingThemeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppearanceCheck()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        settingThemeView.darkButtonTapHandler = {
            UserDefaultManager.set("dark", forKey: UserDefaultKey.THEME_MODE)
            self.settingThemeView.setTheme(theme: .dark)
            self.viewWillAppear(true)
        }
        
        settingThemeView.lightButtonTapHandler = {
            UserDefaultManager.set("light", forKey: UserDefaultKey.THEME_MODE)
            self.settingThemeView.setTheme(theme: .light)
            self.viewWillAppear(true)
        }
        
        settingThemeView.backButtonTapHandler = {
            self.popVC()
        }
    }
}
