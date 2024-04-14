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
        label.text = L10n.suggestReplyDeveloper
        return label
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 15)
        label.textColor = Asset.Color.gray1.color
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
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
        addSubviews([
            titleLabel,
            replyImageView,
            contentsLabel,
            createDateLabel
        ])
    }
    
    override func initConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(replyImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(contentsLabel.snp.top).offset(-5)
        }
        
        replyImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
            make.trailing.equalTo(contentsLabel.snp.leading).offset(-15)
            make.size.equalTo(24)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(replyImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(createDateLabel.snp.top).offset(-10)
        }
        
        createDateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
