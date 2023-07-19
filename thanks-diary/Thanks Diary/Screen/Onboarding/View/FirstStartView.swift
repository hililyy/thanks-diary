//
//  FirstStartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit
import Then
import SnapKit

final class FirstStartView: BaseView {
    
    var lottieView = UIView()
    
    var lottieView2 = UIView()
    
    private var messageLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = Font.NANUM_ULTRALIGHT_18
        $0.text = """
                    단순히 일기를 작성하는건
                    
                    부정적인 감정에 집중하기 쉬워요.
                    
                    감사일기를 작성하면
                    
                    긍정적인 감정에 집중할 수 있어요!
                    """
    }
    
    override func configureUI() {
        backgroundColor = .clear
    }
    
    override func addSubView() {
        addSubview(lottieView)
        addSubview(lottieView2)
        addSubview(messageLabel)
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
