//
//  FloatingButtonOpendView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit
import SnapKit

final class FloatingButtonOpendView: BaseView {
    
    // MARK: - UI components
    
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        return view
    }()
    
    var backgroundButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    var closeButton: FloatingButton = {
        let button = FloatingButton()
        button.setButtonImage(img: Asset.Image.icX.image,
                              color: Asset.Color.cleanWhite.color)
        button.setButtonBackgroundColor(ResourceManager.instance.getMainColor())
        button.button.accessibilityIdentifier = "button_main_floating_close"
        return button
    }()
    
    var detailButton: FloatingButton = {
        let button = FloatingButton()
        button.setButtonImage(img: Asset.Image.icDetailWrite.image,
                              color: ResourceManager.instance.getMainColor())
        button.setButtonBackgroundColor(.white)
        button.button.accessibilityIdentifier = "button_main_floating_detail"
        return button
    }()
    
    var simpleButton: FloatingButton = {
        let button = FloatingButton()
        button.setButtonImage(img: Asset.Image.icSimpleWrite.image,
                              color: ResourceManager.instance.getMainColor())
        button.setButtonBackgroundColor(.white)
        button.button.accessibilityIdentifier = "button_main_floating_simple"
        return button
    }()
    
    var detailLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.font = ResourceManager.instance.getFont(size: 13)
        label.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    var simpleLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.font = ResourceManager.instance.getFont(size: 13)
        label.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    // MARK: - Functions
    
    var detailButtonCenterY: Constraint!
    var simpleButtonCenterY: Constraint!
    
    func setDetailLabel(label: String) {
        detailLabel.text = label
    }
    
    func setSimpleLabel(label: String) {
        simpleLabel.text = label
    }
    
    func setOpenConstraints() {
        detailButtonCenterY.update(offset: -80)
        simpleButtonCenterY.update(offset: -160)
    }

    func setCloseConstraints() {
        detailButtonCenterY.update(offset: 0)
        simpleButtonCenterY.update(offset: 0)
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            backgroundView,
            backgroundButton,
            closeButton,
            detailButton,
            simpleButton,
            detailLabel,
            simpleLabel
        ])
    }
    
    override func initConstraints() {
        detailButton.snp.makeConstraints { make in
            detailButtonCenterY = make.centerY.equalTo(closeButton.snp.centerY).constraint
        }

        simpleButton.snp.makeConstraints { make in
            simpleButtonCenterY = make.centerY.equalTo(closeButton.snp.centerY).constraint
        }
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(40)
            make.size.equalTo(52)
        }
        
        detailButton.snp.makeConstraints { make in
            make.centerX.equalTo(closeButton)
            make.size.equalTo(52)
        }
        
        simpleButton.snp.makeConstraints { make in
            make.centerX.equalTo(closeButton)
            make.size.equalTo(52)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(detailButton)
            make.trailing.equalTo(detailButton.snp.leading).offset(-10)
        }
        
        simpleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(simpleButton)
            make.trailing.equalTo(simpleButton.snp.leading).offset(-10)
        }
    }
}
