//
//  ThemeColorView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/18.
//

import UIKit

final class ThemeColorView: BaseView {
    
    // MARK: - UI components
    
    private let colorTitleLabel = UILabel().then { label in
        label.initLabelUI(text: L10n.colorSet,
                          color: Asset.Color.blackColor.color,
                          font: ResourceManager.instance?.getFont(size: 15) ?? FontFamily.NanumBarunGothic.ultraLight.font(size: 20))
    }
    
    private lazy var colorStackView = UIStackView(arrangedSubviews: [
        blueButton,
        pinkButton,
        yellowButton,
        greenButton,
        purpleButton]).then { stackView in
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
    
    // MARK: - UI, Target
    
    override func initSubviews() {
        addSubviews([colorTitleLabel,
                     colorStackView
                    ])
    }
    
    override func initConstraints() {
        colorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.height.equalTo(25)
        }
        
        colorStackView.snp.makeConstraints { make in
            make.top.equalTo(colorTitleLabel.snp.bottom).offset(25)
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(snp.bottom)
        }
        
        for button in [blueButton,
                       pinkButton,
                       yellowButton,
                       greenButton,
                       purpleButton] {
            initColorButtonSize(button)
        }
    }
    
    func initColorButtonSize(_ sender: UIButton) {
        sender.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
}
