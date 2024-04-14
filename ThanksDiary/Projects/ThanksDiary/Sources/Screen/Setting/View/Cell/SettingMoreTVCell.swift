//
//  SettingMoreCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

final class SettingMoreTVCell: BaseTVCell, CellIdentifier {
    
    // MARK: - UI components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 17)
        label.textColor = Asset.Color.gray1.color
        return label
    }()
    
    let moreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Image.icMore.image
        return imageView
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            titleLabel,
            moreImageView
        ])
    }
    
    override func initConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(15)
        }
        
        moreImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(24)
        }
    }
}
