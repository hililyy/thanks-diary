//
//  SettingThemeView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/17.
//

import UIKit

final class SettingThemeView: BaseView {
    
    // MARK: - UI components
    
    let navigationView = NavigationView()
    let modeView = ThemeModeView()
    let colorView = ThemeColorView()
    let fontView = ThemeFontView()
    private let lineView = LineView(color: Asset.Color.gray5.color)
    private let lineView2 = LineView(color: Asset.Color.gray5.color)
    private let contentView = UIView()
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // MARK: - Functions
    
    func setTheme(theme: ThemeMode) {
        modeView.lightView.alpha = theme == .light ? 1.0 : 0.2
        modeView.darkView.alpha = theme == .dark ? 1.0 : 0.2
    }
    
    func setColorUI(buttonTag: Int) {
        colorView.blueButton.alpha = buttonTag == 0 ? 1.0 : 0.3
        colorView.pinkButton.alpha = buttonTag == 1 ? 1.0 : 0.3
        colorView.yellowButton.alpha = buttonTag == 2 ? 1.0 : 0.3
        colorView.greenButton.alpha = buttonTag == 3 ? 1.0 : 0.3
        colorView.purpleButton.alpha = buttonTag == 4 ? 1.0 : 0.3
    }
    
    func setNavigationTitle(title: String) {
        navigationView.setTitleLabelText(title: title)
    }
    
    // MARK: - UI, Target
    
    func initAllFont() {
        navigationView.titleLabel.font = ResourceManager.instance.getFont(size: 22)
        modeView.modeTitleLabel.font = ResourceManager.instance.getFont(size: 15)
        modeView.lightLabel.font = ResourceManager.instance.getFont(size: 15)
        modeView.darkLabel.font = ResourceManager.instance.getFont(size: 15)
        colorView.colorTitleLabel.font = ResourceManager.instance.getFont(size: 15)
        fontView.fontTitleLabel.font = ResourceManager.instance.getFont(size: 15)
    }
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
        
        let mode = UserDefaultManager.instance.themeMode
        if let themeMode = ThemeMode(rawValue: mode) {
            setTheme(theme: themeMode)
        }
        
        let color = UserDefaultManager.instance.themeColor
        setColorUI(buttonTag: color)
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            navigationView,
            contentScrollView
        ])
        
        contentScrollView.addSubview(contentView)
        
        contentView.addSubviews([
            modeView,
            lineView,
            colorView,
            lineView2,
            fontView
        ])
    }
    
    override func initConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        contentScrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
            make.height.equalToSuperview().priority(.high)
        }
        
        modeView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(35)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(modeView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        colorView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(35)
        }
        
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(colorView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        fontView.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(35)
            make.bottom.equalToSuperview().inset(-20)
        }
    }
}
