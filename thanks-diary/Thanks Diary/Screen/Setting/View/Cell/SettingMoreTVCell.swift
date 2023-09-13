//
//  SettingMoreCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

final class SettingMoreTVCell: BaseTVCell {

    static let id = "SettingMoreTVCell"
    
    // MARK: - UI components
    
    var titleLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY1
    }
    
    var moreImageView = UIImageView().then { imageView in
        imageView.image = Image.IC_MORE
    }
    
    // MARK: - UI, Target
    
    override func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([titleLabel, moreImageView])
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(20)
            make.left.equalTo(snp.left).offset(15)
            make.bottom.equalTo(snp.bottom).offset(-20)
        }
        
        moreImageView.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-10)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }
}
