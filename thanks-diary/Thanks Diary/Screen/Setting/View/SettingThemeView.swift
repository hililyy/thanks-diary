//
//  SettingThemeView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/17.
//

import UIKit

final class SettingThemeView: BaseView {
    
    // MARK: - UI components
    
    private let backButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_BACK, for: .normal)
    }
    
    private let topLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_22
        label.textColor = Color.COLOR_GRAY1
        label.text = "text_setting_name8".localized
        label.textAlignment = .center
    }
    
    private lazy var contentsStackView = UIStackView(arrangedSubviews: [lightContentView, darkContentView]).then { stackView in
        stackView.spacing = 50
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    private let lightContentView = UIView()
    private let darkContentView = UIView()
    
    private let lightView = UIView().then { view in
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = Color.COLOR_GRAY2?.cgColor
    }
    
    private let darkView = UIView().then { view in
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = Color.COLOR_GRAY2?.cgColor
    }
    
    private let lightButton = UIButton(type: .custom)
    private let darkButton = UIButton(type: .custom)
    
    private let lightLabel = UILabel().then { label in
        label.textColor = Color.COLOR_GRAY6
        label.text = "text_lightmode".localized
        label.textAlignment = .center
        label.font = Font.NANUM_LIGHT_15
    }
    
    private let darkLabel = UILabel().then { label in
        label.textColor = Color.COLOR_GRAY6
        label.text = "text_darkmode".localized
        label.textAlignment = .center
        label.font = Font.NANUM_LIGHT_15
    }
    
    // MARK: - Functions
    
    func setTheme(theme: ThemeMode) {
        switch theme {
            
        case .light:
            lightView.alpha = 1.0
            darkView.alpha = 0.2
            
        case .dark:
            lightView.alpha = 0.2
            darkView.alpha = 1.0
        }
    }
    
    // MARK: - UI, Target
    
    var backButtonTapHandler: () -> Void = {}
    var lightButtonTapHandler: () -> Void = {}
    var darkButtonTapHandler: () -> Void = {}
    var systemButtonTapHandler: () -> Void = {}
    
    override func initUI() {
        backgroundColor = Color.COLOR_WHITE
        
        if let mode = UserDefaultManager.instance?.string(UserDefaultKey.THEME_MODE.rawValue),
            let themeMode = ThemeMode(rawValue: mode) {
            setTheme(theme: themeMode)
        }
    }
    
    override func initTarget() {
        backButton.addTarget { _ in
            self.backButtonTapHandler()
        }
        
        lightButton.addTarget { _ in
            self.lightButtonTapHandler()
        }
        
        darkButton.addTarget { _ in
            self.darkButtonTapHandler()
        }
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([backButton,
                     topLabel,
                     contentsStackView
                    ])
        
        lightContentView.addSubviews([
            lightView,
            lightLabel,
            lightButton,
        ])
        
        darkContentView.addSubviews([
            darkView,
            darkLabel,
            darkButton,
        ])
    }
    
    override func initConstraints() {
        backButton.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(topLabel.snp.left).offset(-5)
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.centerY.equalTo(topLabel.snp.centerY)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(25)
            make.height.equalTo(30)
            make.centerX.equalTo(snp.centerX)
        }
        
        contentsStackView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(50)
            make.left.equalTo(snp.left).offset(50)
            make.centerX.equalTo(snp.centerX)
        }

        lightView.snp.makeConstraints { make in
            make.top.equalTo(lightContentView.snp.top)
            make.left.equalTo(lightContentView.snp.left)
            make.right.equalTo(lightContentView.snp.right)
            make.bottom.equalTo(lightLabel.snp.top).offset(-20)
            make.width.equalTo(106)
            make.height.equalTo(106)
        }

        lightLabel.snp.makeConstraints { make in
            make.left.equalTo(lightContentView.snp.left)
            make.right.equalTo(lightContentView.snp.right)
            make.bottom.equalTo(lightContentView.snp.bottom)
            make.height.equalTo(30)
        }
        
        lightButton.snp.makeConstraints { make in
            make.edges.equalTo(lightContentView)
        }
        
        darkView.snp.makeConstraints { make in
            make.top.equalTo(darkContentView.snp.top)
            make.left.equalTo(darkContentView.snp.left)
            make.right.equalTo(darkContentView.snp.right)
            make.bottom.equalTo(darkLabel.snp.top).offset(-20)
            make.width.equalTo(lightView.snp.width)
            make.height.equalTo(lightView.snp.width)
        }

        darkLabel.snp.makeConstraints { make in
            make.left.equalTo(darkContentView.snp.left)
            make.right.equalTo(darkContentView.snp.right)
            make.bottom.equalTo(darkContentView.snp.bottom)
            make.height.equalTo(30)
        }
        
        darkButton.snp.makeConstraints { make in
            make.edges.equalTo(darkContentView)
        }
    }
}
