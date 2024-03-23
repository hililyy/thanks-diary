//
//  SettingCheckTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2024/01/18.
//

import UIKit

final class SettingCheckTVCell: BaseTVCell, CellIdentifier {
    
    // MARK: - UI components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 17)
        label.textColor = Asset.Color.gray1.color
        return label
    }()
    
    let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Image.icCheck.image
        return imageView
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([titleLabel,
                     checkImageView])
    }
    
    override func initConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(20)
            make.left.equalTo(snp.left).offset(15)
            make.bottom.equalTo(snp.bottom).offset(-20)
        }
        
        checkImageView.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-10)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }
}
