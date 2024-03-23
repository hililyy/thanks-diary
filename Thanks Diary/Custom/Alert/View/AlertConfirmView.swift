//
//  AlertConfirmView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/27.
//

import UIKit

final class AlertConfirmView: BaseView {
    
    // MARK: - Property
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 16)
        label.text = L10n.alertErrorMessage
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let messageView = UIView()
    private let buttonView = UIView()
    
    let okButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.ok, for: .normal)
        button.titleLabel?.font = ResourceManager.instance.getFont(size: 17)
        button.backgroundColor = ResourceManager.instance.getMainColor()
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.setTitleColor(Asset.Color.gray1.color, for: .normal)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    private let lineViewX: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray3.color
        return view
    }()
    
    func setText(message: String, okButtonText: String) {
        messageLabel.text = message
        okButton.setTitle(okButtonText, for: .normal)
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([backgroundView, alertView])
        alertView.addSubviews([messageView, buttonView, lineViewX])
        backgroundView.addSubview(backButton)
        messageView.addSubview(messageLabel)
        buttonView.addSubview(okButton)
    }
    
    override func initConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
        alertView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(220)
        }
        
        messageView.snp.makeConstraints { make in
            make.top.equalTo(alertView.snp.top)
            make.left.equalTo(alertView.snp.left)
            make.right.equalTo(alertView.snp.right)
            make.bottom.equalTo(lineViewX.snp.top)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(messageView.snp.centerX)
            make.centerY.equalTo(messageView.snp.centerY).offset(10)
        }
        
        lineViewX.snp.makeConstraints { make in
            make.top.equalTo(messageView.snp.bottom)
            make.left.equalTo(alertView.snp.left)
            make.right.equalTo(alertView.snp.right)
            make.bottom.equalTo(buttonView.snp.top)
            make.height.equalTo(1)
        }
        
        buttonView.snp.makeConstraints { make in
            make.left.equalTo(alertView.snp.left)
            make.right.equalTo(alertView.snp.right)
            make.bottom.equalTo(alertView.snp.bottom)
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.left.equalTo(buttonView.snp.left)
            make.right.equalTo(buttonView.snp.right)
            make.bottom.equalTo(buttonView.snp.bottom)
            make.height.equalTo(55)
        }
    }
}
