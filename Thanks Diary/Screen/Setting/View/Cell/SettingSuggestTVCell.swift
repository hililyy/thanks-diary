//
//  SettingSuggestTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/07.
//

import UIKit

final class SettingSuggestTVCell: BaseTVCell, CellIdentifier {
    
    // MARK: - UI components
    
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
    
    let statusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Image.icLike.image
        return imageView
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 12)
        label.text = "8"
        label.textAlignment = .center
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 12)
        label.textColor = Asset.Color.gray6.color
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubviews([statusView,
                                       createDateLabel])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    let emptyView = UIView()
    
    func setStatusLabelUI(_ type: SuggestType) {
        switch type {
        case .waiting:
            statusView.backgroundColor = Asset.Color.gray5.color
            
        case .progress:
            statusView.backgroundColor = Asset.Color.yellow.color
            
        case .complete:
            statusView.backgroundColor = Asset.Color.lightGrayBlue.color
        }
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([contentsLabel,
                     stackView,
//                     likeImageView,
//                     likeLabel,
//                     likeButton
                    ])
        statusView.addSubview(statusLabel)
    }
    
    override func initConstraints() {
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.left.equalTo(snp.left).offset(15)
//            make.right.equalTo(likeButton.snp.left).offset(-20)
            make.right.equalTo(snp.right).offset(-15)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentsLabel.snp.bottom).offset(10)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(snp.right).offset(-15)
            make.bottom.equalTo(snp.bottom).offset(-10)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(statusView.snp.top).offset(5)
            make.left.equalTo(statusView.snp.left).offset(10)
            make.right.equalTo(statusView.snp.right).offset(-10)
            make.bottom.equalTo(statusView.snp.bottom).offset(-5)
        }
        
//        likeImageView.snp.makeConstraints { make in
//            make.top.equalTo(likeButton.snp.top)
//            make.bottom.equalTo(likeLabel.snp.top)
//            make.centerX.equalTo(likeButton.snp.centerX)
//            make.width.equalTo(24)
//            make.height.equalTo(24)
//        }
//        
//        likeLabel.snp.makeConstraints { make in
//            make.left.equalTo(likeButton.snp.left)
//            make.right.equalTo(likeButton.snp.right)
//            make.bottom.equalTo(likeButton.snp.bottom)
//            
//        }
//        
//        likeButton.snp.makeConstraints { make in
//            make.top.equalTo(snp.top).offset(10)
//            make.right.equalTo(snp.right).offset(-10)
//            make.width.equalTo(20)
//        }
    }
}
