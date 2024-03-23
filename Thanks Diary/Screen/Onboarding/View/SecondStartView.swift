//
//  SecondStartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit

final class SecondStartView: BaseView {
    
    // MARK: - UI components
    
    let lottieView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        label.font = ResourceManager.instance.getFont(size: 25)
        label.text = L10n.startPage2Message1
        return label
    }()
    
    private let heartImageView1 = UIImageView(image: Asset.Image.imgHeart.image)
    private let heartImageView2 = UIImageView(image: Asset.Image.imgHeart.image)
    private let heartImageView3 = UIImageView(image: Asset.Image.imgHeart.image)
    private let heartImageView4 = UIImageView(image: Asset.Image.imgHeart.image)
    
    private let messageLabel1: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .left
        label.font =  ResourceManager.instance.getFont(size: 18)
        label.text = L10n.startPage2Message2
        return label
    }()
    
    private let messageLabel2: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .left
        label.font = ResourceManager.instance.getFont(size: 18)
        label.text = L10n.startPage2Message3
        return label
    }()
    
    private let messageLabel3: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .left
        label.font = ResourceManager.instance.getFont(size: 18)
        label.text = L10n.startPage2Message4
        return label
    }()

    private let messageLabel4: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .left
        label.font = ResourceManager.instance.getFont(size: 18)
        label.text = L10n.startPage2Message5
        return label
    }()
    
    private lazy var messageImageStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var messageImageStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var messageImageStackView3: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var messageImageStackView4: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var messageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 15
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        messageImageStackView1.addArrangedSubviews([heartImageView1, messageLabel1])
        messageImageStackView2.addArrangedSubviews([heartImageView2, messageLabel2])
        messageImageStackView3.addArrangedSubviews([heartImageView3, messageLabel3])
        messageImageStackView4.addArrangedSubviews([heartImageView4, messageLabel4])
        
        messageStackView.addArrangedSubviews([messageImageStackView1,
                                              messageImageStackView2,
                                              messageImageStackView3,
                                              messageImageStackView4])
        
        addSubviews([lottieView,
                     titleLabel,
                     messageStackView])
    }
    
    override func initConstraints() {
        heartImageView1.snp.makeConstraints { make in
            make.width.equalTo(21)
            make.height.equalTo(21)
        }
        
        heartImageView2.snp.makeConstraints { make in
            make.width.equalTo(21)
            make.height.equalTo(21)
        }
        
        heartImageView3.snp.makeConstraints { make in
            make.width.equalTo(21)
            make.height.equalTo(21)
        }
        
        heartImageView4.snp.makeConstraints { make in
            make.width.equalTo(21)
            make.height.equalTo(21)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(messageStackView.snp.top).offset(-100)
        }
        
        messageStackView.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY).offset(-50)
            make.left.equalTo(snp.left).offset(40)
        }
        
        lottieView.snp.makeConstraints { make in
            make.height.equalTo(130)
            make.bottom.equalTo(snp.bottom).offset(-50)
            make.left.equalTo(snp.left).offset(65)
            make.centerX.equalTo(snp.centerX)
        }
    }
}
