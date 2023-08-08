//
//  SettingLabelCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

class SettingLabelTVCell: BaseTVCell {
    
    static let id = "SettingLabelTVCell"
    
    var titleLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY1
    }
    
    var contentsLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY2
    }
    
    override func addSubView() {
        addSubviews([titleLabel, contentsLabel])
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(15)
            make.centerY.equalTo(snp.centerY)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-10)
            make.centerY.equalTo(snp.centerY)
        }
    }
}