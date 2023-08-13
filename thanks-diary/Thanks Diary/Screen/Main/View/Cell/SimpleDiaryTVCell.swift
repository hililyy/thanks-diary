//
//  SimpleDiaryTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/04.
//

import UIKit

final class SimpleDiaryTVCell: BaseTVCell {
    
    static let id = "SimpleDiaryTVCell"
    
    var dotView = UIView().then { view in
        view.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        view.layer.cornerRadius = 3.5
    }
    
    var titleLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY1
    }
    
    override func configureUI() {
        selectionStyle = .none
    }
    
    override func addSubView() {
        addSubviews([dotView, titleLabel])
    }
    
    override func setConstraints() {
        dotView.snp.makeConstraints { make in
            make.width.equalTo(7)
            make.height.equalTo(7)
            make.left.equalTo(snp.left).offset(20)
            make.centerY.equalTo(snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(dotView.snp.right).offset(7)
            make.right.equalTo(20)
            make.centerY.equalTo(snp.centerY)
        }
    }
}
