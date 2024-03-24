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
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font =  ResourceManager.instance.getFont(size: 18)
        label.text = L10n.startPage1Message1
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
            lottieView2,
            messageLabel
        ])
    }
    
    override func initConstraints() {
        lottieView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(75)
            make.centerX.equalToSuperview()
            make.height.equalTo(170)
        }
        
        lottieView2.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(75)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.center.horizontalEdges.equalToSuperview()
        }
    }
}
