//
//  FirstStartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit

final class FirstStartView: BaseView {
    
    var lottieView = UIView()
    var lottieView2 = UIView()
    
    private var messageLabel = UILabel().then { label in
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Font.NANUM_ULTRALIGHT_18
        label.text = "text_start_message1".localized
    }
    
    override func configureUI() {
        backgroundColor = .clear
    }
    
    override func addSubView() {
        addSubviews([lottieView, lottieView2, messageLabel])
    }
    
    override func setConstraints() {
        lottieView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.top.equalTo(snp.top).offset(20)
            make.left.equalTo(snp.left).offset(75)
            make.centerX.equalTo(snp.centerX)
        }
        
        lottieView2.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.bottom.equalTo(snp.bottom).offset(-20)
            make.left.equalTo(snp.left).offset(75)
            make.centerX.equalTo(snp.centerX)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
    }
}
