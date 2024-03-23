//
//  DetailDiaryTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/04.
//

import UIKit

final class DetailDiaryTVCell: BaseTVCell, CellIdentifier {
    
    // MARK: - UI components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 17)
        label.textColor = Asset.Color.gray1.color
        label.numberOfLines = 0
        label.accessibilityIdentifier = "label_cell_detail_title"
        return label
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = ResourceManager.instance.getMainColor().cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
        accessibilityIdentifier = "DetailDiaryTVCell"
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubview(borderView)
        borderView.addSubview(titleLabel)
    }
    
    override func initConstraints() {
        borderView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(5)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(snp.right).offset(-15)
            make.centerY.equalTo(snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.top).offset(15)
            make.left.equalTo(borderView.snp.left).offset(20)
            make.right.equalTo(borderView.snp.right).offset(-20)
            make.bottom.equalTo(borderView.snp.bottom).offset(-15)
            make.height.lessThanOrEqualTo(100)
        }
    }
}
