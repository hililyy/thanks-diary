//
//  SettingSuggestReplyTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2024/01/08.
//

import UIKit

final class SettingSuggestReplyTVCell: BaseTVCell, CellIdentifier {
    
    // MARK: - UI components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 11)
        label.text = "[개발자 답변]"
        return label
    }()
    
    let contentsLabel = UILabel().then { label in
        label.font = ResourceManager.instance.getFont(size: 15)
        label.textColor = Asset.Color.gray1.color
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
    }
    
    let createDateLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 12)
        label.textColor = Asset.Color.gray5.color
        return label
    }()
    
    private let replyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Image.icReply.image
        return imageView
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = Asset.Color.gray12.color
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([titleLabel,
                     replyImageView,
                     contentsLabel,
                     createDateLabel])
    }
    
    override func initConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.left.equalTo(replyImageView.snp.right).offset(15)
            make.right.equalTo(snp.right).offset(-15)
            make.bottom.equalTo(contentsLabel.snp.top).offset(-5)
        }
        
        replyImageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(15)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(contentsLabel.snp.left).offset(-15)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(replyImageView.snp.right).offset(15)
            make.right.equalTo(snp.right).offset(-15)
            make.bottom.equalTo(createDateLabel.snp.top).offset(-10)
        }
        
        createDateLabel.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-15)
            make.bottom.equalTo(snp.bottom).offset(-10)
        }
    }
}
