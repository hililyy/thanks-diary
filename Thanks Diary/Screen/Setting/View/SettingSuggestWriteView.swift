//
//  SettingSuggestWriteView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import UIKit

final class SettingSuggestWriteView: BaseView {
    
    // MARK: - UI components
    
    private let backgroundView = UIView().then { view in
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    lazy var backgroundButton = UIButton(type: .custom).then { button in
        button.backgroundColor = .clear
    }
    
    private let containerView = UIView().then { view in
        view.backgroundColor = Asset.Color.gray4.color
        view.layer.cornerRadius = 10
    }
    
    let mailButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icMail.image, for: .normal)
    }
    
    let contentsTextView = UITextView().then { textView in
        textView.backgroundColor = .clear
        textView.font = FontFamily.NanumBarunGothic.ultraLight.font(size: 17)
        textView.textColor = Asset.Color.gray1.color
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = ResourceManager.instance?.getMainColor().cgColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
        textView.becomeFirstResponder()
    }
    
    let completeButton = UIButton(type: .custom).then { button in
        button.setTitle(L10n.writeComplete, for: .normal)
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
        button.titleLabel?.font = FontFamily.NanumBarunGothic.light.font(size: 15)
        button.backgroundColor = ResourceManager.instance?.getMainColor()
        button.layer.cornerRadius = 10
    }
    
    // MARK: - Functions
    
    func setCompleteButtonEnable(_ isEnabled: Bool) {
        completeButton.isEnabled = isEnabled
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([backgroundView, backgroundButton, containerView])
        containerView.addSubviews([mailButton, contentsTextView, completeButton])
    }
    
    override func initConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(15)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(220)
        }
        
        mailButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(9)
            make.right.equalTo(containerView.snp.right).offset(-9)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        contentsTextView.snp.makeConstraints { make in
            make.left.equalTo(containerView.snp.left).offset(18)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(70)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(contentsTextView.snp.bottom).offset(20)
            make.left.equalTo(contentsTextView.snp.left)
            make.bottom.equalTo(containerView.snp.bottom).offset(-25)
            make.centerX.equalTo(containerView.snp.centerX)
            make.height.equalTo(45)
        }
    }
}
