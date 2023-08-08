//
//  SettingSwitchCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

final class SettingSwitchTVCell: BaseTVCell {

    static let id = "SettingSwitchTVCell"
    
    var titleLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY1
    }
    
    var settingSwitch = UISwitch()
    
    var switchTapHandler: () -> () = {}
    
    override func configureUI() {
        selectionStyle = .none
        
        settingSwitch.addTarget { _ in
            self.switchTapHandler()
        }
    }
    
    override func addSubView() {
        contentView.addSubviews([titleLabel, settingSwitch])
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(settingSwitch.snp.left).offset(-200)
            make.centerY.equalTo(snp.centerY)
        }
        
        settingSwitch.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-30)
            make.centerY.equalTo(snp.centerY)
        }
    }
}
