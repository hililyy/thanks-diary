//
//  ThemeColorView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/18.
//

import UIKit

final class ThemeColorView: BaseView {
    
    // MARK: - UI components
    
    let colorTitleLabel: UILabel = {
        let label = UILabel()
        label.initLabelUI(text: L10n.colorSet,
                          color: Asset.Color.blackColor.color,
                          font: ResourceManager.instance.getFont(size: 15))
        return label
    }()
    
    private lazy var colorStackView: UIStackView = {
        let stackView = UIStackView()
            stackView.initStackViewUI(spacing: 30,
                                      axis: .horizontal)
        return stackView
    }()
    
    let blueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = Asset.Color.grayBlue.color
        button.layer.cornerRadius = 15
        button.tag = 0
        return button
    }()
    
    let pinkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = Asset.Color.pink.color
        button.layer.cornerRadius = 15
        button.tag = 1
        return button
    }()
    
    let yellowButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = Asset.Color.yellow.color
        button.layer.cornerRadius = 15
        button.tag = 2
        return button
    }()
    
    let greenButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = Asset.Color.green.color
        button.layer.cornerRadius = 15
        button.tag = 3
        return button
    }()
    
    let purpleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = Asset.Color.purple.color
        button.layer.cornerRadius = 15
        button.tag = 4
        return button
    }()
    
    // MARK: - UI, Target
    
    override func initSubviews() {
        colorStackView.addArrangedSubviews([
            blueButton,
            pinkButton,
            yellowButton,
            greenButton,
            purpleButton
        ])
        
        addSubviews([
            colorTitleLabel,
            colorStackView
        ])
    }
    
    override func initConstraints() {
        colorTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.equalTo(25)
        }
        
        colorStackView.snp.makeConstraints { make in
            make.top.equalTo(colorTitleLabel.snp.bottom).offset(25)
            make.bottom.centerX.equalToSuperview()
        }
        
        [blueButton,
         pinkButton,
         yellowButton,
         greenButton,
         purpleButton].forEach { button in
            initColorButtonSize(button)
            
        }
    }
    
    private func initColorButtonSize(_ sender: UIButton) {
        sender.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
    }
}
