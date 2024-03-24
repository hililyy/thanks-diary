//
//  ThemeModeView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/18.
//

import UIKit
import SnapKit

final class ThemeModeView: BaseView {
    
    // MARK: - UI components
    
    let modeTitleLabel: UILabel = {
        let label = UILabel()
        label.initLabelUI(text: L10n.modeSet,
                          color: Asset.Color.blackColor.color,
                          font: ResourceManager.instance.getFont(size: 15))
        return label
    }()
    
    private lazy var contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 50
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private let lightContentView = UIView()
    private let darkContentView = UIView()
    
    let lightView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = Asset.Color.gray2.color.cgColor
        return view
    }()
    
    let darkView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = Asset.Color.gray2.color.cgColor
        return view
    }()
    
    let lightButton = UIButton(type: .custom)
    let darkButton = UIButton(type: .custom)
    
    let lightLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Color.blackColor.color
        label.text = L10n.lightmode
        label.textAlignment = .center
        label.font = ResourceManager.instance.getFont(size: 15)
        return label
    }()
    
    let darkLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Color.blackColor.color
        label.text = L10n.darkmode
        label.textAlignment = .center
        label.font = ResourceManager.instance.getFont(size: 15)
        return label
    }()
    
    // MARK: - UI, Target
    
    override func initSubviews() {
        contentsStackView.addArrangedSubviews([
            lightContentView,
            darkContentView
        ])
        
        addSubviews([
            modeTitleLabel,
            contentsStackView
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
        modeTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.equalTo(25)
        }
        
        contentsStackView.snp.makeConstraints { make in
            make.top.equalTo(modeTitleLabel.snp.bottom).offset(25)
            make.bottom.centerX.equalToSuperview()
        }

        lightView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(lightLabel.snp.top).offset(-20)
            make.size.equalTo(106)
        }

        lightLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(30)
        }
        
        lightButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        darkView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(darkLabel.snp.top).offset(-20)
            make.size.equalTo(lightView)
        }

        darkLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(darkContentView)
            make.height.equalTo(30)
        }
        
        darkButton.snp.makeConstraints { make in
            make.edges.equalTo(darkContentView)
        }
    }
}
