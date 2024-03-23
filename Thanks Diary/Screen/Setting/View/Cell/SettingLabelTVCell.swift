//
//  SettingLabelCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

final class SettingLabelTVCell: BaseTVCell, CellIdentifier {
    
    // MARK: - UI components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 17)
        label.textColor = Asset.Color.gray1.color
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 17)
        label.textColor = Asset.Color.gray2.color
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([titleLabel,
                     contentsLabel])
    }
    
    override func initConstraints() {
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
