//
//  SecondStartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit
import Then
import SnapKit

final class SecondStartView: BaseView {
    let lottieView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = Font.NANUM_ULTRALIGHT_25
        $0.text = "감사일기 작성 방법"
    }
    
    private let heartImageView1 = UIImageView(image: UIImage(named: "img_heart"))
    private let heartImageView2 = UIImageView(image: UIImage(named: "img_heart"))
    private let heartImageView3 = UIImageView(image: UIImage(named: "img_heart"))
    private let heartImageView4 = UIImageView(image: UIImage(named: "img_heart"))
    
    private let messageLabel1 = UILabel().then {
        $0.textAlignment = .left
        $0.font = Font.NANUM_ULTRALIGHT_18
        $0.text = "긍정문으로 작성해요"
    }
    
    private let messageLabel2 = UILabel().then {
        $0.textAlignment = .left
        $0.font = Font.NANUM_ULTRALIGHT_18
        $0.text = "작은 일에도 감사한일을 찾아보아요"
    }
    
    private let messageLabel3 = UILabel().then {
        $0.textAlignment = .left
        $0.font = Font.NANUM_ULTRALIGHT_18
        $0.text = "매일매일 작성해요"
    }

    private let messageLabel4 = UILabel().then {
        $0.textAlignment = .left
        $0.font = Font.NANUM_ULTRALIGHT_18
        $0.text = "감사한 일을 항상 생각해요"
    }
    
    private lazy var messageImageStackView1 = UIStackView(arrangedSubviews: [heartImageView1, messageLabel1]).then {
        $0.spacing = 5
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    private lazy var messageImageStackView2 = UIStackView(arrangedSubviews: [heartImageView2, messageLabel2]).then {
        $0.spacing = 5
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    private lazy var messageImageStackView3 = UIStackView(arrangedSubviews: [heartImageView3, messageLabel3]).then {
        $0.spacing = 5
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    private lazy var messageImageStackView4 = UIStackView(arrangedSubviews: [heartImageView4, messageLabel4]).then {
        $0.spacing = 5
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    private lazy var messageStackView = UIStackView(arrangedSubviews: [messageImageStackView1, messageImageStackView2, messageImageStackView3, messageImageStackView4]).then {
        $0.spacing = 15
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    override func configureUI() {
        backgroundColor = .clear
    }
    
    override func addSubView() {
        addSubviews([lottieView, titleLabel, messageStackView])
    }
    
    override func setConstraints() {
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
