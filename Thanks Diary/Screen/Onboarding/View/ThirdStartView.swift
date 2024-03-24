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
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        label.font = ResourceManager.instance.getFont(size: 20)
        label.numberOfLines = 0
        label.text = L10n.startPage3Message1
        return label
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = .clear
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            lottieView,
            messageLabel
        ])
    }
    
    override func initConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.centerX.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(lottieView.snp.top).offset(-50)
        }
        
        lottieView.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.bottom.equalToSuperview().inset(150)
            make.leading.equalToSuperview().inset(75)
            make.centerX.equalToSuperview()
        }
    }
}
