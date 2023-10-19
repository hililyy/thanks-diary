//
//  ThemeModeView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/18.
//

import UIKit
import SnapKit
import Then

final class ThemeModeView: BaseView {
    private let modeTitleLabel = UILabel().then { label in
        label.initLabelUI(text: L10n.modeSet,
                          color: Asset.Color.blackColor.color,
                          font: ResourceManager.instance?.getFont(size: 15) ?? FontFamily.NanumBarunGothic.ultraLight.font(size: 15))
    }
    
    private lazy var contentsStackView = UIStackView(arrangedSubviews: [
        lightContentView,
        darkContentView]).then { stackView in
            stackView.spacing = 50
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
        }
    
    private let lightContentView = UIView()
    private let darkContentView = UIView()
    
    let lightView = UIView().then { view in
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = Asset.Color.gray2.color.cgColor
    }
    
    let darkView = UIView().then { view in
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = Asset.Color.gray2.color.cgColor
    }
    
    let lightButton = UIButton(type: .custom)
    let darkButton = UIButton(type: .custom)
    
    private let lightLabel = UILabel().then { label in
        label.textColor = Asset.Color.blackColor.color
        label.text = L10n.lightmode
        label.textAlignment = .center
        label.font = ResourceManager.instance?.getFont(size: 15)
    }
    
    private let darkLabel = UILabel().then { label in
        label.textColor = Asset.Color.blackColor.color
        label.text = L10n.darkmode
        label.textAlignment = .center
        label.font = ResourceManager.instance?.getFont(size: 15)
    }
    
    override func initSubviews() {
        addSubviews([modeTitleLabel,
                     contentsStackView])
        
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
        modeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.height.equalTo(25)
        }
        
        contentsStackView.snp.makeConstraints { make in
            make.top.equalTo(modeTitleLabel.snp.bottom).offset(25)
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(snp.bottom)
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
