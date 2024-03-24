//
//  SettingPWView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/24.
//

import UIKit

final class SettingPWView: BaseView {
    
    // MARK: - UI components
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icBack.image, for: .normal)
        return button
    }()
    
    private let lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Image.imgLock.image
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.password
        label.font = ResourceManager.instance.getFont(size: 22)
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        return label
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.passwordContents1
        label.font = ResourceManager.instance.getFont(size: 17)
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dotStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 45
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private let dotViews: [UIView] = (0..<4).map { _ in
        let view = UIView()
        view.backgroundColor = Asset.Color.gray7.color
        view.layer.cornerRadius = 7
        return view
    }
    
    private lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var passwordRowStackViews: [UIStackView] = {
        return (0..<4).map { _ in
            let row = UIStackView()
            row.axis = .horizontal
            row.spacing = 15
            row.distribution = .fillEqually
            row.alignment = .fill
            return row
        }
    }()
    
    private let passwordNumberButtonViews: [PasswordButtonView] = {
        return (0...9).map { number in
            let button = PasswordButtonView(number: number)
            return button
        }
    }()
    
    let deleteButton = PasswordButtonView(number: -1)

    private let emptyView = UIView()
    
    // MARK: - Functions
    
    func setContentsLabel(text: String, textColor: UIColor = Asset.Color.gray1.color) {
        contentsLabel.text = text
        contentsLabel.textColor = textColor
    }
    
    func setDotColor(num: Int) {
        let gray = Asset.Color.gray7.color
        let blue = ResourceManager.instance.getMainColor()
        
        dotViews[0].backgroundColor = num > 0 ? blue : gray
        dotViews[1].backgroundColor = num > 1 ? blue : gray
        dotViews[2].backgroundColor = num > 2 ? blue : gray
        dotViews[3].backgroundColor = gray
    }
    
//    func shakeContentsLabel() {
//        let animation = CAKeyframeAnimation()
//        animation.keyPath = "position.x"
//        animation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
//        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
//        animation.duration = 0.4
//        animation.isAdditive = true
//        
//        contentsLabel.layer.add(animation, forKey: "shake")
//    }
    
    // MARK: - UI, Target
    
    var numberButtonTapHandler: (Int) -> Void = { _ in }
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    override func initTarget() {
        for view in passwordNumberButtonViews {
            view.button.addTarget { _ in
                self.numberButtonTapHandler(view.button.tag)
            }
        }
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        passwordStackView.addArrangedSubviews([
            passwordRowStackViews[0],
            passwordRowStackViews[1],
            passwordRowStackViews[2],
            passwordRowStackViews[3]
        ])
        
        passwordRowStackViews[0].addArrangedSubviews([
            passwordNumberButtonViews[1],
            passwordNumberButtonViews[2],
            passwordNumberButtonViews[3]
        ])
        
        passwordRowStackViews[1].addArrangedSubviews([
            passwordNumberButtonViews[4],
            passwordNumberButtonViews[5],
            passwordNumberButtonViews[6]
        ])
        
        passwordRowStackViews[2].addArrangedSubviews([
            passwordNumberButtonViews[7],
            passwordNumberButtonViews[8],
            passwordNumberButtonViews[9]
        ])
        
        passwordRowStackViews[3].addArrangedSubviews([
            emptyView,
            passwordNumberButtonViews[0],
            deleteButton
        ])
        
        addSubviews([
            backButton,
            lockImageView,
            titleLabel,
            contentsLabel,
            dotStackView,
            passwordStackView
        ])
        
        dotStackView.addArrangedSubviews([
            dotViews[0],
            dotViews[1],
            dotViews[2],
            dotViews[3]
        ])
    }
    
    override func initConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(25)
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(44)
        }
        
        lockImageView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).offset(-30)
            make.size.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentsLabel.snp.top).offset(-5)
            make.centerX.equalToSuperview()
            make.height.equalTo(30).priority(999)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dotStackView.snp.top).offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(30).priority(999)
        }
        
        dotStackView.snp.makeConstraints { make in
            make.bottom.equalTo(passwordStackView.snp.top).offset(-40)
            make.height.equalTo(14)
            make.centerX.equalToSuperview()
        }
        
        passwordStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-40)
            make.centerX.equalToSuperview()
        }
        
        dotViews.forEach { dotView in
            dotView.snp.makeConstraints { make in
                make.width.equalTo(dotView.snp.height)
            }
        }
        
        passwordNumberButtonViews.forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height)
            }
        }
    }
}
