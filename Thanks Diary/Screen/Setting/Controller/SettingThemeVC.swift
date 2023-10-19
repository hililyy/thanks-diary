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
    
    private var settingThemeView = SettingThemeView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        settingThemeView.fontView.fontTableView.setContentOffset(CommonUtilManager.instance?.tableViewOffset ?? .zero, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAppearance()
    }
    
    deinit {
        CommonUtilManager.instance?.tableViewOffset = .zero
    }
    
    // MARK: - Function
    
    private func selectDarkTheme() {
        UserDefaultManager.instance?.set(ThemeMode.dark.rawValue,
                                         key: UserDefaultKey.THEME_MODE.rawValue)
        settingThemeView.setTheme(theme: .dark)
        viewWillAppear(true)
    }
    
    private func selectLightTheme() {
        UserDefaultManager.instance?.set(ThemeMode.light.rawValue,
                                         key: UserDefaultKey.THEME_MODE.rawValue)
        settingThemeView.setTheme(theme: .light)
        viewWillAppear(true)
    }
    
    private func saveThemeColor(type: Int) {
        UserDefaultManager.instance?.set(type, key: UserDefaultKey.THEME_COLOR.rawValue)
    }
    
    private func saveThemeFont(type: Int) {
        UserDefaultManager.instance?.set(type, key: UserDefaultKey.THEME_FONT.rawValue)
    }
    
    private func saveTableViewPosition() {
        CommonUtilManager.instance?.tableViewOffset = settingThemeView.fontView.fontTableView.contentOffset
    }
}

// MARK: - initalize

extension SettingThemeVC {
    private func initalize() {
        initView()
        initDelegate()
        initTarget()
    }
    
    private func initView() {
        view.removeAllSubViews()
        settingThemeView = SettingThemeView()
        view.addSubview(settingThemeView)
        settingThemeView.setAutoLayout(to: view)
    }
    
    private func initDelegate() {
        settingThemeView.fontView.fontTableView.delegate = self
        settingThemeView.fontView.fontTableView.dataSource = self
    }
    
    private func initTarget() {
        initDarkButtonTarget()
        initLightButtonTarget()
        initBackButtonTarget()
        initColorButtonTarget()
    }
    
    private func initDarkButtonTarget() {
        settingThemeView.modeView.darkButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                selectDarkTheme()
                saveTableViewPosition()
            })
            .disposed(by: disposeBag)
    }
    
    private func initLightButtonTarget() {
        settingThemeView.modeView.lightButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                selectLightTheme()
                saveTableViewPosition()
            })
            .disposed(by: disposeBag)
    }
    
    private func initBackButtonTarget() {
        settingThemeView.navigationView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initColorButtonTarget() {
        for button in [settingThemeView.colorView.blueButton,
                       settingThemeView.colorView.pinkButton,
                       settingThemeView.colorView.yellowButton,
                       settingThemeView.colorView.greenButton,
                       settingThemeView.colorView.purpleButton] {
            
            button.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] in
                    guard let self else { return }
                    settingThemeView.setColorUI(buttonTag: button.tag)
                    saveThemeColor(type: button.tag)
                    saveTableViewPosition()
                    
                    CommonUtilManager.instance?.themeSubject.onNext(button.tag)
                    self.initalize()
                    
                })
                .disposed(by: disposeBag)
        }
    }
}

// MARK: - TableView

extension SettingThemeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FontType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = settingThemeView.fontView.fontTableView.dequeueReusableCell(withIdentifier: RadioTVCell.id, for: indexPath) as? RadioTVCell else { return UITableViewCell() }
        
        guard let type = FontType(rawValue: indexPath.row) else { return UITableViewCell() }
        cell.contentsLabel.initLabelUI(text: type.description,
                                       color: Asset.Color.gray1.color,
                                       font: ResourceManager.instance?.getFont(type: type, size: 18) ?? FontFamily.NanumBarunGothic.ultraLight.font(size: 20))
        
        let savedFontType = UserDefaultManager.instance?.int(UserDefaultKey.THEME_FONT.rawValue)
        cell.changeButtonUI(isSelected: savedFontType == type.rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = FontType(rawValue: indexPath.row) else { return }
        saveThemeFont(type: type.rawValue)
        saveTableViewPosition()
        CommonUtilManager.instance?.themeSubject.onNext(type.rawValue)
        initalize()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
