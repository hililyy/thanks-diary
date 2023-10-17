//
//  SettingThemeView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/17.
//

import UIKit

final class SettingThemeView: BaseView {
    
    // MARK: - UI components
    
    let backButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icBack.image, for: .normal)
    }
    
    private let topLabel = UILabel().then { label in
        label.font = FontFamily.NanumBarunGothic.ultraLight.font(size: 22)
        label.textColor = Asset.Color.gray1.color
        label.text = L10n.settingName8
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
        view.layer.borderColor = Asset.Color.gray2.color.cgColor
    }
    
    private let darkView = UIView().then { view in
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = Asset.Color.gray2.color.cgColor
    }
    
    let lightButton = UIButton(type: .custom)
    let darkButton = UIButton(type: .custom)
    
    private let lightLabel = UILabel().then { label in
        label.textColor = Asset.Color.gray6.color
        label.text = L10n.lightmode
        label.textAlignment = .center
        label.font = FontFamily.NanumBarunGothic.light.font(size: 15)
    }
    
    private let darkLabel = UILabel().then { label in
        label.textColor = Asset.Color.gray6.color
        label.text = L10n.darkmode
        label.textAlignment = .center
        label.font = FontFamily.NanumBarunGothic.light.font(size: 15)
    }
    
    private let lineView = UIView().then { view in
        view.backgroundColor = Asset.Color.gray5.color
    }
    
    private let colorTitleLabel = UILabel().then { label in
        label.initLabelUI(text: L10n.colorSet, color: Asset.Color.blackColor.color, font: FontFamily.NanumBarunGothic.light.font(size: 15))
    }
    
    private lazy var colorStackView = UIStackView(arrangedSubviews: [blueButton, pinkButton, yellowButton, greenButton, purpleButton]).then { stackView in
        stackView.initStackViewUI(spacing: 30,
                                  axis: .horizontal)
    }
    
    let blueButton = UIButton().then { button in
        button.backgroundColor = Asset.Color.grayBlue.color
        button.layer.cornerRadius = 15
        button.tag = 0
    }
    
    let pinkButton = UIButton().then { button in
        button.backgroundColor = Asset.Color.pink.color
        button.layer.cornerRadius = 15
        button.tag = 1
    }
    
    let yellowButton = UIButton().then { button in
        button.backgroundColor = Asset.Color.yellow.color
        button.layer.cornerRadius = 15
        button.tag = 2
    }
    
    let greenButton = UIButton().then { button in
        button.backgroundColor = Asset.Color.green.color
        button.layer.cornerRadius = 15
        button.tag = 3
    }
    
    let purpleButton = UIButton().then { button in
        button.backgroundColor = Asset.Color.purple.color
        button.layer.cornerRadius = 15
        button.tag = 4
    }
    
    // MARK: - Functions
    
    func setTheme(theme: ThemeMode) {
        lightView.alpha = theme == .light ? 1.0 : 0.2
        darkView.alpha = theme == .dark ? 1.0 : 0.2
    }
    
    func setColorUI(buttonTag: Int) {
        blueButton.alpha = buttonTag == 0 ? 1.0 : 0.3
        pinkButton.alpha = buttonTag == 1 ? 1.0 : 0.3
        yellowButton.alpha = buttonTag == 2 ? 1.0 : 0.3
        greenButton.alpha = buttonTag == 3 ? 1.0 : 0.3
        purpleButton.alpha = buttonTag == 4 ? 1.0 : 0.3
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
        
        if let mode = UserDefaultManager.instance?.string(UserDefaultKey.THEME_MODE.rawValue),
           let themeMode = ThemeMode(rawValue: mode) {
            setTheme(theme: themeMode)
        }
        
        if let mode = UserDefaultManager.instance?.int(UserDefaultKey.THEME_COLOR.rawValue) {
            setColorUI(buttonTag: mode)
        } else {
            setColorUI(buttonTag: 0)
        }
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            backButton,
            topLabel,
            contentsStackView,
            lineView,
            colorTitleLabel,
            colorStackView
        ])
        
        lightContentView.addSubviews([
            lightView,
            lightLabel,
            lightButton
        ])
        
        darkContentView.addSubviews([
            darkView,
            darkLabel,
            darkButton
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
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(contentsStackView.snp.bottom).offset(70)
            make.left.equalTo(snp.left).offset(30)
            make.right.equalTo(snp.right).offset(-30)
            make.height.equalTo(1)
        }
        
        colorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(30)
            make.left.equalTo(snp.left).offset(30)
        }
        
        colorStackView.snp.makeConstraints { make in
            make.top.equalTo(colorTitleLabel.snp.bottom).offset(25)
            make.centerX.equalTo(snp.centerX)
        }
        
        blueButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        pinkButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        yellowButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        greenButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        purpleButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
}
