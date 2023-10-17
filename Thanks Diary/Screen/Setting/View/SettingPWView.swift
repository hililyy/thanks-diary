//
//  SettingPWView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/24.
//

import UIKit

final class SettingPWView: BaseView {
    
    // MARK: - UI components
    
    let backButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icBack.image, for: .normal)
    }
    
    private let lockImageView = UIImageView().then { imageView in
        imageView.image = Asset.Image.imgLock.image
    }
    
    private let titleLabel = UILabel().then { label in
        label.text = L10n.password
        label.font = FontFamily.NanumBarunGothic.ultraLight.font(size: 22)
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
    }
    
    private let contentsLabel = UILabel().then { label in
        label.text = L10n.passwordContents1
        label.font = FontFamily.NanumBarunGothic.ultraLight.font(size: 17)
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
    }
    
    private let dotView = UIView()
    
    private let firstDotView = UIView().then { view in
        view.backgroundColor = Asset.Color.gray7.color
        view.layer.cornerRadius = 10
    }
    
    private let secondDotView = UIView().then { view in
        view.backgroundColor = Asset.Color.gray7.color
        view.layer.cornerRadius = 10
    }
    
    private let thirdDotView = UIView().then { view in
        view.backgroundColor = Asset.Color.gray7.color
        view.layer.cornerRadius = 10
    }
    
    private let fourthDotView = UIView().then { view in
        view.backgroundColor = Asset.Color.gray7.color
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
    
    private lazy var passwordFourthStackView = UIStackView(arrangedSubviews: [emptyView, zeroButton, deleteButton]).then { stackView in
        stackView.axis = .horizontal
        stackView.spacing = 15
    }
    
    private let oneButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icOne.image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.adjustsImageWhenHighlighted = false
        button.tag = 1
    }
    
    private let twoButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icTwo.image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.adjustsImageWhenHighlighted = false
        button.tag = 2
    }
    
    private let threeButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icThree.image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.adjustsImageWhenHighlighted = false
        button.tag = 3
    }
    
    private let fourButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icFour.image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.adjustsImageWhenHighlighted = false
        button.tag = 4
    }
    
    private let fiveButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icFive.image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.adjustsImageWhenHighlighted = false
        button.tag = 5
    }
    
    private let sixButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icSix.image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.adjustsImageWhenHighlighted = false
        button.tag = 6
    }
    
    private let sevenButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icSeven.image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.adjustsImageWhenHighlighted = false
        button.tag = 7
    }
    
    private let eightButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icEight.image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.adjustsImageWhenHighlighted = false
        button.tag = 8
    }
    
    private let nineButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icNine.image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.adjustsImageWhenHighlighted = false
        button.tag = 9
    }
    
    private let zeroButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icZero.image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.adjustsImageWhenHighlighted = false
        button.tag = 0
    }
    
    let deleteButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icDelete.image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.adjustsImageWhenHighlighted = false
    }
    
    private let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    // MARK: - Functions
    
    func setContentsLabel(text: String, textColor: UIColor = Asset.Color.gray1.color) {
        contentsLabel.text = text
        contentsLabel.textColor = textColor
    }
    
    func setDotColor(num: Int) {
        let gray = Asset.Color.gray7.color
        let blue = CommonUtilManager.instance?.getMainColor()
        
        firstDotView.backgroundColor = num > 0 ? blue : gray
        secondDotView.backgroundColor = num > 1 ? blue : gray
        thirdDotView.backgroundColor = num > 2 ? blue : gray
        fourthDotView.backgroundColor = gray
    }
    
    // MARK: - UI, Target
    
    var numberButtonTapHandler: (Int) -> Void = { _ in }
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    override func initTarget() {
        for button in [oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton, zeroButton] {
            button.addTarget { _ in
                self.numberButtonTapHandler(button.tag)
            }
        }
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([backButton,
                     lockImageView,
                     titleLabel,
                     contentsLabel,
                     dotView,
                     passwordStackView])
        
        dotView.addSubviews([
            firstDotView,
            secondDotView,
            thirdDotView,
            fourthDotView
        ])
    }
    
    override func initConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(25)
            make.left.equalTo(snp.left).offset(20)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
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
            make.bottom.equalTo(dotView.snp.top).offset(-30)
            make.centerX.equalTo(snp.centerX)
        }
        
        dotView.snp.makeConstraints { make in
            make.bottom.equalTo(passwordStackView.snp.top).offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(20)
        }

        firstDotView.snp.makeConstraints { make in
            make.top.equalTo(dotView.snp.top)
            make.left.equalTo(dotView.snp.left)
            make.right.equalTo(secondDotView.snp.left).offset(-45)
            make.bottom.equalTo(dotView.snp.bottom)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        secondDotView.snp.makeConstraints { make in
            make.top.equalTo(dotView.snp.top)
            make.left.equalTo(firstDotView.snp.right).offset(45)
            make.bottom.equalTo(dotView.snp.bottom)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        thirdDotView.snp.makeConstraints { make in
            make.top.equalTo(dotView.snp.top)
            make.left.equalTo(secondDotView.snp.right).offset(45)
            make.bottom.equalTo(dotView.snp.bottom)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        fourthDotView.snp.makeConstraints { make in
            make.top.equalTo(dotView.snp.top)
            make.left.equalTo(thirdDotView.snp.right).offset(45)
            make.bottom.equalTo(dotView.snp.bottom)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        passwordStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalTo(snp.centerX)
        }
    }
}
