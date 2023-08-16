//
//  SimpleDiaryTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/04.
//

import UIKit

final class SimpleDiaryTVCell: BaseTVCell {
    
    static let id = "SimpleDiaryTVCell"
    
    var dotView = UIView().then {
        $0.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        $0.layer.cornerRadius = 3.5
    }
    
    var titleLabel = UILabel().then {
        $0.font = Font.NANUM_ULTRALIGHT_17
        $0.textColor = Color.COLOR_GRAY1
    }
    
    override func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
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
