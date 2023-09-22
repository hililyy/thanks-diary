//
//  FirstStartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit

final class FirstStartView: BaseView {
    
    // MARK: - UI components
    
    var lottieView = UIView()
    var lottieView2 = UIView()
    
    private var messageLabel = UILabel().then { label in
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Font.NANUM_ULTRALIGHT_18
        label.text = "text_start_message1".localized
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([lottieView,
                     lottieView2,
                     messageLabel])
    }
    
    override func initConstraints() {
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
