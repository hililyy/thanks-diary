//
//  FloatingButtonCloseView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit
import SnapKit
import Then

final class FloatingButtonCloseView: BaseView {
    
    lazy var backgroundView = UIView().then { view in
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    lazy var backgroundButton = UIButton(type: .custom).then { button in
        button.backgroundColor = .clear
    }
    
    var plusButton = FloatingButton().then { button in
        button.setButtonImage(UIImage(named: "ic_x") ?? .add)
        button.setButtonBackgroundColor(Color.COLOR_LIGHTGRAYBLUE)
    }
    
    var detailButton = FloatingButton().then { button in
        button.setButtonImage(UIImage(named: "ic_detail_write") ?? .remove)
        button.setButtonBackgroundColor(.white)
    }
    
    var simpleButton = FloatingButton().then { button in
        button.setButtonImage(UIImage(named: "ic_simple_write") ?? .actions)
        button.setButtonBackgroundColor(.white)
    }
    
    var detailLabel = PaddingLabel().then { label in
        label.font = Font.NANUM_LIGHT_13
        label.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .right
    }
    
    var simpleLabel = PaddingLabel().then { label in
        label.font = Font.NANUM_LIGHT_13
        label.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .right
    }
    
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
    
    override func addSubView() {
        addSubview(backgroundView)
        addSubview(backgroundButton)
        addSubview(plusButton)
        addSubview(detailButton)
        addSubview(simpleButton)
        addSubview(detailLabel)
        addSubview(simpleLabel)
    }
    
    override func setConstraints() {
        detailButton.snp.makeConstraints { make in
            detailButtonCenterY = make.centerY.equalTo(plusButton.snp.centerY).constraint
        }

        simpleButton.snp.makeConstraints { make in
            simpleButtonCenterY = make.centerY.equalTo(plusButton.snp.centerY).constraint
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
        
        plusButton.snp.makeConstraints { make in
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-40)
            make.bottom.equalTo(snp.bottom).offset(-40)
            make.width.equalTo(52)
            make.height.equalTo(52)
        }
        
        detailButton.snp.makeConstraints { make in
            make.centerX.equalTo(plusButton.snp.centerX)
            make.width.equalTo(52)
            make.height.equalTo(52)
        }
        
        simpleButton.snp.makeConstraints { make in
            make.centerX.equalTo(plusButton.snp.centerX)
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
