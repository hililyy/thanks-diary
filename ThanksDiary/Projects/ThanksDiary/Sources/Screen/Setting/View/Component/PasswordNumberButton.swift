//
//  PasswordNumberButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/11/21.
//

import UIKit
import SnapKit

final class PasswordButtonView: UIView {
    let button: UIButton = {
        let button = UIButton(type: .custom)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 2
        view.layer.borderColor = Asset.Color.gray7.color.cgColor
        return view
    }()
    
    convenience init(number: Int) {
        self.init()
        button.tag = number
        initalize()
    }
    
    private func initalize() {
        setupContentView(number: button.tag)
        initSubViews()
        initConstraints()
    }
    
    private func initSubViews() {
        addSubview(contentView)
        addSubview(button)
    }
    
    private func initConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().priority(.high)
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupContentView(number: Int) {
        snp.makeConstraints { make in
            make.size.equalTo(60).priority(.high)
        }
        
        if number == -1 {
            let contentImageView = UIImageView()
            contentImageView.image = Asset.Image.icDelete.image
            contentImageView.tintColor = .red
            contentView.addSubview(contentImageView)
            
            contentImageView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(32)
            }
        } else {
            let contentLabel = UILabel()
            contentLabel.text = "\(number)"
            contentLabel.textColor = Asset.Color.gray1.color
            contentLabel.textAlignment = .center
            contentLabel.font = ResourceManager.instance.getFont(size: 30)
            contentView.addSubview(contentLabel)
            
            contentLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
