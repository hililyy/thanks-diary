//
//  NotTodayView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/16.
//

import UIKit
import SnapKit

final class NotTodayView: BaseView {
    
    // MARK: - UI components
    
    let contentView = UIView()
    let topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ResourceManager.instance.getMainColor()
        view.layer.cornerRadius = 2
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.initLabelUI(text: L10n.todayNotTitle,
                          color: Asset.Color.blackColor.color,
                          font: ResourceManager.instance.getFont(size: 21))
        label.setCharacterSpacing()
        return label
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.initLabelUI(text: L10n.todayNotContents,
                          color: Asset.Color.blackColor.color,
                          font: ResourceManager.instance.getFont(size: 12))
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 5)
        label.setCharacterSpacing(spacing: 0)
        return label
    }()
    
    let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ResourceManager.instance.getMainColor()
        view.layer.cornerRadius = 2
        return view
    }()
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubview(contentView)
        
        contentView.addSubviews([
            topLineView,
            bottomLineView,
            titleLabel,
            contentsLabel
        ])
    }
    
    override func initConstraints() {
        contentView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(160)
            make.center.equalToSuperview()
        }
        
        topLineView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLineView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
    }
}
