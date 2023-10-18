//
//  SimpleDiaryTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/04.
//

import UIKit

final class SimpleDiaryTVCell: BaseTVCell, CellIdentifier {
    
    // MARK: - UI components
    
    let dotView = UIView().then { view in
        view.backgroundColor = ResourceManager.instance?.getMainColor()
        view.layer.cornerRadius = 3.5
    }
    
    let titleLabel = UILabel().then { label in
        label.font = FontFamily.NanumBarunGothic.ultraLight.font(size: 17)
        label.textColor = Asset.Color.gray1.color
        label.numberOfLines = 0
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([dotView, titleLabel])
    }
    
    override func initConstraints() {
        dotView.snp.makeConstraints { make in
            make.width.equalTo(7)
            make.height.equalTo(7)
            make.left.equalTo(snp.left).offset(20)
            make.centerY.equalTo(snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(15)
            make.left.equalTo(dotView.snp.right).offset(7)
            make.right.equalTo(snp.right).offset(-20)
            make.bottom.equalTo(snp.bottom).offset(-5)
        }
    }
}
