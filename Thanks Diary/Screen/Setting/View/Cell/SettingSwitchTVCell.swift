//
//  SettingSwitchCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

final class SettingSwitchTVCell: BaseTVCell {

    static let id = "SettingSwitchTVCell"
    
    // MARK: - UI components
    
    let titleLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY1
    }
    
    let settingSwitch = UISwitch()
    
    var switchTapHandler: () -> Void = {}
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        settingSwitch.onTintColor = Asset.Color.lightGrayBlue.color
        settingSwitch.addTarget { _ in
            self.switchTapHandler()
        }
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        contentView.addSubviews([titleLabel, settingSwitch])
    }
    
    override func initConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
        settingSwitch.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(20)
            make.right.equalTo(snp.right).offset(-20)
            make.bottom.equalTo(snp.bottom).offset(-20)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
}
