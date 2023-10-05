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
        initTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAppearance()
    }
    
    // MARK: - Function
    
    private func initTarget() {
        settingThemeView.darkButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                UserDefaultManager.instance?.set(ThemeMode.dark.rawValue, key: UserDefaultKey.THEME_MODE.rawValue)
                settingThemeView.setTheme(theme: .dark)
                viewWillAppear(true)
            })
            .disposed(by: disposeBag)
        
        settingThemeView.lightButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                UserDefaultManager.instance?.set(ThemeMode.light.rawValue, key: UserDefaultKey.THEME_MODE.rawValue)
                settingThemeView.setTheme(theme: .light)
                viewWillAppear(true)
            })
            .disposed(by: disposeBag)
        
        settingThemeView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                popVC()
            })
            .disposed(by: disposeBag)
    }
}
