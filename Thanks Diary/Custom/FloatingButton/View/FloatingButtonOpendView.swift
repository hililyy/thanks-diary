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
    
    var backgroundView = UIView().then { view in
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    var backgroundButton = UIButton(type: .custom).then { button in
        button.backgroundColor = .clear
    }
    
    var closeButton = FloatingButton().then { button in
        button.setButtonImage(Asset.Image.icX.image)
        button.setButtonBackgroundColor(ResourceManager.instance.getMainColor())
        button.button.accessibilityIdentifier = "button_main_floating_close"
    }
    
    var detailButton = FloatingButton().then { button in
        button.setButtonImage(ResourceManager.instance.getDetailWriteImage())
        button.setButtonBackgroundColor(.white)
        button.button.accessibilityIdentifier = "button_main_floating_detail"
    }
    
    var simpleButton = FloatingButton().then { button in
        button.setButtonImage(ResourceManager.instance.getSimpleWriteImage())
        button.setButtonBackgroundColor(.white)
        button.button.accessibilityIdentifier = "button_main_floating_simple"
    }
    
    var detailLabel = PaddingLabel().then { label in
        label.font = ResourceManager.instance.getFont(size: 13)
        label.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .right
        label.textColor = .black
    }
    
    var simpleLabel = PaddingLabel().then { label in
        label.font = ResourceManager.instance.getFont(size: 13)
        label.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .right
        label.textColor = .black
    }
    
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
        addSubviews([backgroundView,
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
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
        closeButton.snp.makeConstraints { make in
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-40)
            make.bottom.equalTo(snp.bottom).offset(-40)
            make.width.equalTo(52)
            make.height.equalTo(52)
        }
        
        detailButton.snp.makeConstraints { make in
            make.centerX.equalTo(closeButton.snp.centerX)
            make.width.equalTo(52)
            make.height.equalTo(52)
        }
        
        simpleButton.snp.makeConstraints { make in
            make.centerX.equalTo(closeButton.snp.centerX)
            make.width.equalTo(52)
            make.height.equalTo(52)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(detailButton.snp.centerY)
            make.right.equalTo(detailButton.snp.left).offset(-10)
        }
        
        simpleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(simpleButton.snp.centerY)
            make.right.equalTo(simpleButton.snp.left).offset(-10)
        }
    }
}
