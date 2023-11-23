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
        label.font = ResourceManager.instance.getFont(size: 22)
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
    }
    
    private let contentsLabel = UILabel().then { label in
        label.text = L10n.passwordContents1
        label.font = ResourceManager.instance.getFont(size: 17)
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
    }
    
    private lazy var dotStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 45
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private let dotViews: [UIView] = (0..<4).map { _ in
        UIView().then {
            $0.backgroundColor = Asset.Color.gray7.color
            $0.layer.cornerRadius = 10
            $0.snp.makeConstraints { make in
                make.width.equalTo(20)
                make.height.equalTo(20)
            }
        }
    }
    
    private lazy var passwordStackView = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.spacing = 25
    }
    
    private lazy var passwordRowStackViews: [UIStackView] = {
        return (0..<4).map { _ in
            let row = UIStackView()
            row.axis = .horizontal
            row.spacing = 15
            return row
        }
    }()
    
    private let passwordNumberButtons: [PasswordNumberButton] = {
        return (0...9).map { number in
            let button = PasswordNumberButton(number: number)
            return button
        }
    }()
    
    let deleteButton = PasswordNumberButton(number: -1)

    private let emptyView = UIView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: 80,
                                                 height: 80))
    
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
    
    // MARK: - UI, Target
    
    var numberButtonTapHandler: (Int) -> Void = { _ in }
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    override func initTarget() {
        for button in passwordNumberButtons {
            button.addTarget { _ in
                self.numberButtonTapHandler(button.tag)
            }
        }
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        passwordStackView.addArrangedSubviews([passwordRowStackViews[0],
                                               passwordRowStackViews[1],
                                               passwordRowStackViews[2],
                                               passwordRowStackViews[3]])
        
        passwordRowStackViews[0].addArrangedSubviews([passwordNumberButtons[1],
                                                      passwordNumberButtons[2],
                                                      passwordNumberButtons[3]])
        
        passwordRowStackViews[1].addArrangedSubviews([passwordNumberButtons[4],
                                                      passwordNumberButtons[5],
                                                      passwordNumberButtons[6]])
        
        passwordRowStackViews[2].addArrangedSubviews([passwordNumberButtons[7],
                                                      passwordNumberButtons[8],
                                                      passwordNumberButtons[9]])
        
        passwordRowStackViews[3].addArrangedSubviews([emptyView,
                                                      passwordNumberButtons[0],
                                                      deleteButton])
        
        addSubviews([backButton,
                     lockImageView,
                     titleLabel,
                     contentsLabel,
                     dotStackView,
                     passwordStackView])
        
        dotStackView.addArrangedSubviews([dotViews[0],
                                          dotViews[1],
                                          dotViews[2],
                                          dotViews[3]])
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
            make.bottom.equalTo(dotStackView.snp.top).offset(-30)
            make.centerX.equalTo(snp.centerX)
        }
        
        dotStackView.snp.makeConstraints { make in
            make.bottom.equalTo(passwordStackView.snp.top).offset(-50)
            make.centerX.equalToSuperview()
        }
        
        passwordStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalTo(snp.centerX)
        }
    }
}
