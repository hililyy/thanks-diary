//
//  SettingPWView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/24.
//

import UIKit

class SettingPWView: BaseView {
    var lockImageView = UIImageView().then { imageView in
        imageView.image = Image.IMG_LOCK
    }
    
    var titleLabel = UILabel().then { label in
        label.text = "text_password".localized
        label.font = Font.NANUM_ULTRALIGHT_22
        label.textColor = .black
        label.textAlignment = .center
    }
    
    var contentsLabel = UILabel().then { label in
        label.text = "text_password_contents".localized
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .center
    }
    
    private lazy var dotStackView =  UIStackView(arrangedSubviews: [firstDotView, secondDotView, thirdDotView, fourthDotView]).then { stackView in
        stackView.spacing = 45
        stackView.axis = .horizontal
    }
    
    var firstDotView = UIView().then { view in
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.backgroundColor = Color.COLOR_GRAY3
        view.layer.cornerRadius = 10
    }
    
    var secondDotView = UIView().then { view in
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.backgroundColor = Color.COLOR_GRAY3
        view.layer.cornerRadius = 10
    }
    
    var thirdDotView = UIView().then { view in
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.backgroundColor = Color.COLOR_GRAY3
        view.layer.cornerRadius = 10
    }
    
    var fourthDotView = UIView().then { view in
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.backgroundColor = Color.COLOR_GRAY3
        view.layer.cornerRadius = 10
    }
    
    private lazy var passwordStackView = UIStackView(arrangedSubviews: [passwordFirstStackView, passwordSecondStackView, passwordThirdStackView, passwordFourthStackView]).then { stackView in
        stackView.axis = .vertical
        stackView.spacing = 25
    }
    
    private lazy var passwordFirstStackView = UIStackView(arrangedSubviews: [oneButton, twoButton, threeButton]).then { stackView in
        stackView.axis = .horizontal
        stackView.spacing = 15
    }
    
    private lazy var passwordSecondStackView = UIStackView(arrangedSubviews: [fourButton, fiveButton, sixButton]).then { stackView in
        stackView.axis = .horizontal
        stackView.spacing = 15
    }
    
    private lazy var passwordThirdStackView = UIStackView(arrangedSubviews: [sevenButton, eightButton, nineButton]).then { stackView in
        stackView.axis = .horizontal
        stackView.spacing = 15
    }
    
    private lazy var passwordFourthStackView = UIStackView(arrangedSubviews: [emptyView, zeroButton, backButton]).then { stackView in
        stackView.axis = .horizontal
        stackView.spacing = 15
    }
    
    let oneButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_ONE, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    let twoButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_TWO, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    let threeButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_THREE, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    let fourButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_FOUR, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    let fiveButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_FIVE, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    let sixButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_SIX, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    let sevenButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_SEVEN, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    let eightButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_EIGHT, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    let nineButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_NINE, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    let zeroButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_ZERO, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    let backButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_DELETE, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
    let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func addSubView() {
        addSubviews([lockImageView,
                     titleLabel,
                     contentsLabel,
                     dotStackView,
                     passwordStackView])
    }
    
    override func setConstraints() {
        lockImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(70)
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(titleLabel.snp.top).offset(-30)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentsLabel.snp.top).offset(-5)
            make.centerX.equalTo(snp.centerX)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dotStackView.snp.top).offset(-30)
            make.centerX.equalTo(snp.centerX)
        }
        
        dotStackView.snp.makeConstraints { make in
            make.bottom.equalTo(passwordStackView.snp.top).offset(-50)
            make.centerX.equalTo(snp.centerX)
        }
        
        passwordStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalTo(snp.centerX)
        }
    }
}
