//
//  ThirdStartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit
import Then
import SnapKit

final class ThirdStartView: UIView {
    var lottieView = UIView()
    
    private var messageLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = Font.NANUM_ULTRALIGHT_20
        $0.numberOfLines = 0
        $0.text = """
                    감사일기를 작성하고
                    나다운 하루를 만들어 보세요!
                    """
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addSubView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .clear
    }
    
    private func addSubView() {
        addSubview(lottieView)
        addSubview(messageLabel)
    }
    
    private func setConstraints() {
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
