//
//  ThirdStartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit

final class ThirdStartView: BaseView {
    
    // MARK: - UI components
    
    var lottieView = UIView()
    
    private var messageLabel = UILabel().then { label in
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .center
        label.font = Font.NANUM_ULTRALIGHT_20
        label.numberOfLines = 0
        label.text = "text_start_message3".localized
    }
    
    // MARK: - UI, Target
    
    override func configureUI() {
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([lottieView, messageLabel])
    }
    
    override func setConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(lottieView.snp.top).offset(-50)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        
        lottieView.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.bottom.equalTo(snp.bottom).offset(-150)
            make.left.equalTo(snp.left).offset(75)
            make.centerX.equalTo(snp.centerX)
        }
    }
}
