//
//  AlertConfirmView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/27.
//

import UIKit

class AlertConfirmView: UIView {
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = Font.NANUM_ULTRALIGHT_16
        label.text = "오류가 발생했습니다.\n\n오류내용을 joun406@gmail.com으로 보내주시면 빠르게 수정하겠습니다. 감사합니다!"
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let messageView: UIView = {
        let view = UIView()
        return view
    }()
    
    let buttonView: UIView = {
        let view = UIView()
        return view
    }()
    
    let okButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = Font.NANUM_ULTRALIGHT_17
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    private var lineViewX: UIView = {
        let view = UIView()
        view.backgroundColor = Color.COLOR_GRAY3
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        addSubview(alertView)
        alertView.addSubview(messageView)
        messageView.addSubview(messageLabel)
        alertView.addSubview(buttonView)
        alertView.addSubview(lineViewX)
        buttonView.addSubview(okButton)
    }
    
    private func setConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        alertView.translatesAutoresizingMaskIntoConstraints = false
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        lineViewX.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            backButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            alertView.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: centerYAnchor),
            alertView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            alertView.heightAnchor.constraint(equalToConstant: 220),
            
            messageView.topAnchor.constraint(equalTo: alertView.topAnchor),
            messageView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            messageView.bottomAnchor.constraint(equalTo: lineViewX.topAnchor),
            
            messageLabel.centerXAnchor.constraint(equalTo: messageView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: messageView.centerYAnchor, constant: 10),
            
            lineViewX.topAnchor.constraint(equalTo: messageView.bottomAnchor),
            lineViewX.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            lineViewX.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            lineViewX.bottomAnchor.constraint(equalTo: buttonView.topAnchor),
            lineViewX.heightAnchor.constraint(equalToConstant: 1),
            
            buttonView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor),
            
            okButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
            okButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            okButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            okButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
            okButton.heightAnchor.constraint(equalToConstant: 55),
            
        ])
    }
}
