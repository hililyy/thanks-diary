//
//  SettingSuggestWriteView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import UIKit

final class SettingSuggestWriteView: BaseView {
    
    // MARK: - UI components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    lazy var backgroundButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray4.color
        view.layer.cornerRadius = 10
        return view
    }()
    
    let mailButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icMail.image, for: .normal)
        return button
    }()
    
    let contentsTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = ResourceManager.instance.getFont(size: 17)
        textView.textColor = Asset.Color.gray1.color
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = ResourceManager.instance.getMainColor().cgColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
        textView.becomeFirstResponder()
        return textView
    }()
    
    let completeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.writeComplete, for: .normal)
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
        button.titleLabel?.font = ResourceManager.instance.getFont(size: 15)
        button.backgroundColor = ResourceManager.instance.getMainColor()
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Functions
    
    func setCompleteButtonEnable(_ isEnabled: Bool) {
        completeButton.isEnabled = isEnabled
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            backgroundView,
            backgroundButton,
            containerView
        ])
        
        containerView.addSubviews([
            mailButton,
            contentsTextView,
            completeButton
        ])
    }
    
    override func initConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.center.equalToSuperview()
            make.height.equalTo(220)
        }
        
        mailButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(9)
            make.size.equalTo(44)
        }
        
        contentsTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(contentsTextView.snp.bottom).offset(20)
            make.leading.equalTo(contentsTextView)
            make.bottom.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
    }
}
