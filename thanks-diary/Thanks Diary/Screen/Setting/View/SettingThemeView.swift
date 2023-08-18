//
//  SettingThemeView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/17.
//

import UIKit

final class SettingThemeView: BaseView {
    
    // MARK: - UI components
    
    private var backButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_BACK, for: .normal)
    }
    
    private var topLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_22
        label.textColor = Color.COLOR_GRAY1
        label.text = "테마 선택"
        label.textAlignment = .center
    }
    
    private lazy var contentsStackView = UIStackView(arrangedSubviews: [lightView, darkView]).then { stackView in
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    private var lightView = UIView().then { view in
        view.layer.cornerRadius = 10
    }
    
    private var darkView = UIView().then { view in
        view.layer.cornerRadius = 10
    }
    
    private var lightImageView = UIImageView().then { imageView in
        imageView.image = Image.IMG_SREEN_LIGHT
        imageView.contentMode = .scaleAspectFit
    }
    
    private var darkImageView = UIImageView().then { imageView in
        imageView.image = Image.IMG_SREEN_DARK
        imageView.contentMode = .scaleAspectFit
    }
    
    private var lightButton = UIButton(type: .custom)
    private var darkButton = UIButton(type: .custom)
    
    private var lightLabel = UILabel().then { label in
        label.textColor = Color.COLOR_GRAY6
        label.text = "라이트 모드"
        label.textAlignment = .center
        label.font = Font.NANUM_LIGHT_17
    }
    
    private var darkLabel = UILabel().then { label in
        label.textColor = Color.COLOR_GRAY6
        label.text = "다크 모드"
        label.textAlignment = .center
        label.font = Font.NANUM_LIGHT_17
    }
    
    // MARK: - Functions
    
    func setTheme(theme: ThemeMode) {
        if theme == .light {
            lightImageView.alpha = 1.0
            lightView.backgroundColor = .lightGray
            lightView.layer.borderWidth = 0
            
            darkImageView.alpha = 0.2
            darkView.backgroundColor = .clear
            
        } else {
            darkImageView.alpha = 1.0
            darkView.backgroundColor = .lightGray
            darkView.layer.borderWidth = 0
            
            lightImageView.alpha = 0.2
            lightView.backgroundColor = .clear
        }
    }
    
    // MARK: - UI, Target
    
    var backButtonTapHandler: () -> () = {}
    var lightButtonTapHandler: () -> () = {}
    var darkButtonTapHandler: () -> () = {}
    
    override func configureUI() {
        backgroundColor = Color.COLOR_WHITE
        
        if let mode = ThemeMode(rawValue: UserDefaultManager.string(forKey: UserDefaultKey.THEME_MODE)) {
            setTheme(theme: mode)
        }
    }
    
    override func setTarget() {
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

        lightView.addSubviews([
            lightImageView,
            lightLabel,
            lightButton,
        ])

        darkView.addSubviews([
            darkImageView,
            darkLabel,
            darkButton,
        ])
    }
    
    override func setConstraints() {
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
            make.left.equalTo(snp.left).offset(20)
            make.bottom.equalTo(snp.bottom).offset(-300)
            make.centerX.equalTo(snp.centerX)
        }

        lightImageView.snp.makeConstraints { make in
            make.top.equalTo(lightView.snp.top)
            make.left.equalTo(lightView.snp.left).offset(10)
            make.right.equalTo(lightView.snp.right).offset(-10)
            make.bottom.equalTo(lightLabel.snp.top).offset(-20)
            make.width.equalTo(darkImageView)
            make.height.equalTo(darkImageView)
        }

        lightLabel.snp.makeConstraints { make in
            make.left.equalTo(lightView.snp.left)
            make.right.equalTo(lightView.snp.right)
            make.bottom.equalTo(lightView.snp.bottom).offset(-20)
        }
        
        lightButton.snp.makeConstraints { make in
            make.edges.equalTo(lightView)
        }

        darkImageView.snp.makeConstraints { make in
            make.top.equalTo(darkView.snp.top)
            make.left.equalTo(darkView.snp.left).offset(10)
            make.right.equalTo(darkView.snp.right).offset(-10)
            make.bottom.equalTo(darkLabel.snp.top).offset(-20)
            make.width.equalTo(lightImageView)
            make.height.equalTo(lightImageView)
        }

        darkLabel.snp.makeConstraints { make in
            make.left.equalTo(darkView.snp.left)
            make.right.equalTo(darkView.snp.right)
            make.bottom.equalTo(darkView.snp.bottom).offset(-20)
        }
        
        darkButton.snp.makeConstraints { make in
            make.edges.equalTo(darkView)
        }
    }
}
