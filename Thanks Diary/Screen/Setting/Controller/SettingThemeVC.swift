//
//  SettingThemeVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/17.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingThemeVC: BaseVC<SettingThemeView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAppearance()
    }
    
    deinit {
        CommonUtilManager.instance.tableViewOffset = .zero
    }
    
    // MARK: - Function
    
    private func selectDarkTheme() {
        UserDefaultManager.instance.themeMode = ThemeMode.dark.rawValue
        attachedView.setTheme(theme: .dark)
        viewWillAppear(true)
    }
    
    private func selectLightTheme() {
        UserDefaultManager.instance.themeMode = ThemeMode.light.rawValue
        attachedView.setTheme(theme: .light)
        viewWillAppear(true)
    }
    
    private func saveThemeColor(type: Int) {
        UserDefaultManager.instance.themeColor = type
    }
    
    private func saveThemeFont(type: Int) {
        UserDefaultManager.instance.themeFont = type
    }
    
    private func saveTableViewPosition() {
        CommonUtilManager.instance.tableViewOffset = attachedView.fontView.fontTableView.contentOffset
    }
}

// MARK: - initalize

extension SettingThemeVC {
    private func initalize() {
        initNavigationTitle()
        initDelegate()
        initTarget()
    }
    
    private func initView() {
        initNavigationTitle()
        attachedView.fontView.fontTableView.reloadData()
        attachedView.fontView.fontTableView.setContentOffset(CommonUtilManager.instance.tableViewOffset, animated: false)
        attachedView.initAllFont()
    }
    
    private func initDelegate() {
        attachedView.fontView.fontTableView.delegate = self
        attachedView.fontView.fontTableView.dataSource = self
    }
    
    private func initTarget() {
        initDarkButtonTarget()
        initLightButtonTarget()
        initBackButtonTarget()
        initColorButtonTarget()
    }
    
    private func initDarkButtonTarget() {
        attachedView.modeView.darkButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                selectDarkTheme()
                saveTableViewPosition()
            })
            .disposed(by: disposeBag)
    }
    
    private func initLightButtonTarget() {
        attachedView.modeView.lightButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                selectLightTheme()
                saveTableViewPosition()
            })
            .disposed(by: disposeBag)
    }
    
    private func initBackButtonTarget() {
        attachedView.navigationView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initColorButtonTarget() {
        for button in [attachedView.colorView.blueButton,
                       attachedView.colorView.pinkButton,
                       attachedView.colorView.yellowButton,
                       attachedView.colorView.greenButton,
                       attachedView.colorView.purpleButton] {
            
            button.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] in
                    guard let self else { return }
                    attachedView.setColorUI(buttonTag: button.tag)
                    saveThemeColor(type: button.tag)
                    saveTableViewPosition()
                    
                    CommonUtilManager.instance.themeSubject.onNext(button.tag)
                    
                    initView()
                    
                })
                .disposed(by: disposeBag)
        }
    }
    
    func initNavigationTitle() {
        attachedView.setNavigationTitle(title: L10n.settingName8)
    }
}

// MARK: - TableView

extension SettingThemeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FontType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = attachedView.fontView.fontTableView.dequeueReusableCell(withIdentifier: RadioTVCell.id, for: indexPath) as? RadioTVCell else { return UITableViewCell() }
        
        guard let type = FontType(rawValue: indexPath.row) else { return UITableViewCell() }
        cell.contentsLabel.initLabelUI(text: type.description,
                                       color: Asset.Color.gray1.color,
                                       font: ResourceManager.instance.getFont(type: type, size: 18))
        
        let savedFontType = UserDefaultManager.instance.themeFont
        cell.changeButtonUI(isSelected: savedFontType == type.rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = FontType(rawValue: indexPath.row) else { return }
        saveThemeFont(type: type.rawValue)
        saveTableViewPosition()
        CommonUtilManager.instance.themeSubject.onNext(type.rawValue)
        initView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
