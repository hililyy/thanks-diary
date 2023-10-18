//
//  NotBeforeView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/16.
//

import UIKit
import SnapKit
import Then

final class NotBeforeView: BaseView {
    let contentView = UIView()
    let topLineView = UIView().then { view in
        view.backgroundColor = ResourceManager.instance?.getMainColor()
        view.layer.cornerRadius = 2
    }
    
    let contentsLabel = UILabel().then { label in
        label.initLabelUI(text: L10n.notExistDiary,
                          color: Asset.Color.blackColor.color,
                          font: FontFamily.NanumBarunGothic.light.font(size: 21))
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 5)
        label.setCharacterSpacing(spacing: 0)
    }
    
    let bottomLineView = UIView().then { view in
        view.backgroundColor = ResourceManager.instance?.getMainColor()
        view.layer.cornerRadius = 2
    }
    
    override func initSubviews() {
        addSubview(contentView)
        contentView.addSubviews([topLineView,
                                 bottomLineView,
                                 contentsLabel])
    }
    
    override func initConstraints() {
        contentView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(160)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
        }
        
        topLineView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(2)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(2)
        }
    }
}
