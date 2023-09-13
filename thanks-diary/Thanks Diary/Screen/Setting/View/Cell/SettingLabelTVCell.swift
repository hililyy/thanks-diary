//
//  SettingLabelCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

final class SettingLabelTVCell: BaseTVCell {
    
    static let id = "SettingLabelTVCell"
    
    // MARK: - UI components
    
    var titleLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY1
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
    }
    
    var contentsLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY2
        label.textAlignment = .right
    }
    
    // MARK: - UI, Target
    
    override func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([titleLabel, contentsLabel])
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(20)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(contentsLabel.snp.left).offset(-10)
            make.bottom.equalTo(snp.bottom).offset(-20)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-10)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
}
