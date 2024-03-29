//
//  NotBeforeView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/16.
//

import UIKit
import SnapKit

final class NotBeforeView: BaseView {
    
    // MARK: - UI components
    
    let contentView = UIView()
    let topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ResourceManager.instance.getMainColor()
        view.layer.cornerRadius = 2
        return view
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.initLabelUI(text: L10n.notExistDiary,
                          color: Asset.Color.blackColor.color,
                          font: ResourceManager.instance.getFont(size: 21))
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
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(2)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
    }
}
