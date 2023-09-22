//
//  DetailDiaryTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/04.
//

import UIKit

final class DetailDiaryTVCell: BaseTVCell {
    
    static let id = "DetailDiaryTVCell"
    
    // MARK: - UI components
    
    let titleLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY1
        label.numberOfLines = 0
    }
    
    let borderView = UIView().then { view in
        view.layer.cornerRadius = 10
        view.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
        view.layer.borderWidth = 2
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
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
