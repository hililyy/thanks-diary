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
    
    lazy var backgroundView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    lazy var backgroundButton = UIButton(type: .custom).then {
        $0.backgroundColor = .clear
    }
    
    var plusButton = FloatingButton().then {
        $0.setButtonImage(UIImage(named: "ic_x") ?? .add)
        $0.setButtonBackgroundColor(Color.COLOR_LIGHTGRAYBLUE)
    }
    
    var detailButton = FloatingButton().then {
        $0.setButtonImage(UIImage(named: "ic_detail_write") ?? .remove)
        $0.setButtonBackgroundColor(.white)
    }
    
    var simpleButton = FloatingButton().then {
        $0.setButtonImage(UIImage(named: "ic_simple_write") ?? .actions)
        $0.setButtonBackgroundColor(.white)
    }
    
    var detailLabel = PaddingLabel().then {
        $0.font = Font.NANUM_LIGHT_13
        $0.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.textAlignment = .right
    }
    
    var simpleLabel = PaddingLabel().then {
        $0.font = Font.NANUM_LIGHT_13
        $0.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.textAlignment = .right
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