//
//  SecondStartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit

final class SecondStartView: BaseView {
    
    // MARK: - UI components
    
    let lottieView = UIView() // 로티설정도 요기서 
    
    private let titleLabel = UILabel().then { label in
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .center
        label.font = Font.NANUM_ULTRALIGHT_25
        label.text = "text_start_message2_1".localized
    }
    
    private let heartImageView1 = UIImageView(image: UIImage(named: "img_heart"))
    private let heartImageView2 = UIImageView(image: UIImage(named: "img_heart"))
    private let heartImageView3 = UIImageView(image: UIImage(named: "img_heart"))
    private let heartImageView4 = UIImageView(image: UIImage(named: "img_heart"))
    
    private let messageLabel1 = UILabel().then { label in
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .left
        label.font = Font.NANUM_ULTRALIGHT_18
        label.text = "text_start_message2_2".localized
    }
    
    private let messageLabel2 = UILabel().then { label in
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .left
        label.font = Font.NANUM_ULTRALIGHT_18
        label.text = "text_start_message2_3".localized
    }
    
    private let messageLabel3 = UILabel().then { label in
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .left
        label.font = Font.NANUM_ULTRALIGHT_18
        label.text = "text_start_message2_4".localized
    }

    private let messageLabel4 = UILabel().then { label in
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .left
        label.font = Font.NANUM_ULTRALIGHT_18
        label.text = "text_start_message2_5".localized
    }
    
    private lazy var messageImageStackView1 = UIStackView(arrangedSubviews: [heartImageView1, messageLabel1]).then { stackView in
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    private lazy var messageImageStackView2 = UIStackView(arrangedSubviews: [heartImageView2, messageLabel2]).then { stackView in
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    private lazy var messageImageStackView3 = UIStackView(arrangedSubviews: [heartImageView3, messageLabel3]).then { stackView in
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    private lazy var messageImageStackView4 = UIStackView(arrangedSubviews: [heartImageView4, messageLabel4]).then { stackView in
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    private lazy var messageStackView = UIStackView(arrangedSubviews: [messageImageStackView1, messageImageStackView2, messageImageStackView3, messageImageStackView4]).then { stackView in
        stackView.spacing = 15
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
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
