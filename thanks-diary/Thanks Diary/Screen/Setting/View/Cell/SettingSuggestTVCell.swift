//
//  SettingSuggestTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/07.
//

import UIKit

final class SettingSuggestTVCell: BaseTVCell {
    
    static let id = "SettingSuggestTVCell"
    
    // MARK: - UI components
    
    let contentsLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY1
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
    }
    
    let statusView = UIView().then { view in
        view.layer.cornerRadius = 10
    }
    
    let statusLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_15
        label.textColor = Color.COLOR_GRAY6
        label.textAlignment = .center
    }
    
    func setStatusLabelUI(_ type: SuggestType) {
        switch type {
        case .waiting:
            statusView.backgroundColor = Color.COLOR_GRAY5
        case .progress:
            statusView.backgroundColor = Color.COLOR_YELLOW
        case .complete:
            statusView.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        }
    }
    
    // MARK: - UI, Target
    
    override func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([contentsLabel, statusView])
        statusView.addSubview(statusLabel)
    }
    
    override func setConstraints() {
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(15)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(statusLabel.snp.left).offset(-10)
            make.bottom.equalTo(snp.bottom).offset(-15)
            make.centerY.equalTo(snp.centerY)
        }
        
        statusView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(15)
            make.right.equalTo(snp.right).offset(-10)
            make.bottom.equalTo(snp.bottom).offset(-15)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(80)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(statusView.snp.top).offset(15)
            make.bottom.equalTo(statusView.snp.bottom).offset(-15)
            make.left.equalTo(statusView.snp.left)
            make.right.equalTo(statusView.snp.right)
        }
    }
}
