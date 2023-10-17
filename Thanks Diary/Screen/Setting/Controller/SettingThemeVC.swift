//
//  SettingThemeVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/17.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingThemeVC: BaseVC {
    
    // MARK: - Property
    
    private let settingThemeView = SettingThemeView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = settingThemeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAppearance()
    }
    
    // MARK: - Function
    
    private func selectDarkTheme() {
        UserDefaultManager.instance?.set(ThemeMode.dark.rawValue, key: UserDefaultKey.THEME_MODE.rawValue)
        settingThemeView.setTheme(theme: .dark)
        viewWillAppear(true)
    }
    
    private func selectLightTheme() {
        UserDefaultManager.instance?.set(ThemeMode.light.rawValue, key: UserDefaultKey.THEME_MODE.rawValue)
        settingThemeView.setTheme(theme: .light)
        viewWillAppear(true)
    }
}

// MARK: - initalize

extension SettingThemeVC {
    private func initalize() {
        initTarget()
    }
    
    private func initTarget() {
        initDarkButtonTarget()
        initLightButtonTarget()
        initBackButtonTarget()
        initColorButtonTarget()
    }
    
    private func initDarkButtonTarget() {
        settingThemeView.darkButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                selectDarkTheme()
            })
            .disposed(by: disposeBag)
    }
    
    private func initLightButtonTarget() {
        settingThemeView.lightButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                selectLightTheme()
            })
            .disposed(by: disposeBag)
    }
    
    private func initBackButtonTarget() {
        settingThemeView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initColorButtonTarget() {
        for button in [settingThemeView.blueButton,
                       settingThemeView.pinkButton,
                       settingThemeView.yellowButton,
                       settingThemeView.greenButton,
                       settingThemeView.purpleButton] {
            button.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] in
                    guard let self else { return }
                    settingThemeView.setColorUI(buttonTag: button.tag)
                    presentAlertVC(themeNum: button.tag)
                })
                .disposed(by: disposeBag)
        }
    }
    
    private func saveThemeColor(num: Int) {
        UserDefaultManager.instance?.set(num, key: UserDefaultKey.THEME_COLOR.rawValue)
    }
}

extension SettingThemeVC {
    func presentAlertVC(themeNum: Int) {
        let vc = AlertVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.alertView.setText(message: L10n.restartApp,
                             leftButtonText: L10n.cancel,
                             rightButtonText: L10n.exit)
        vc.rightButtonTapHandler = { [weak self] in
            guard let self else { return }
            
            UserDefaultManager.instance?.set(themeNum, key: UserDefaultKey.THEME_COLOR.rawValue)
            self.exitApp()
        }
        present(vc, animated: true)
    }
}
