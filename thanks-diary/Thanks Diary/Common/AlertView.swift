//
//  AlertView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/12.
//

import UIKit

class AlertView: UIView {
    
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
        label.font = Font.NANUM_LIGHT_20
        label.text = "글을 삭제 하시겠습니까?"
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .center
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
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_17
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("삭제", for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_17
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.layer.cornerRadius = 10
            button.layer.maskedCorners = [.layerMaxXMaxYCorner]
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
    
    private var lineViewY: UIView = {
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
        buttonView.addSubview(cancelButton)
        buttonView.addSubview(deleteButton)
        buttonView.addSubview(lineViewY)
    }
    
    private func setConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        alertView.translatesAutoresizingMaskIntoConstraints = false
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        lineViewX.translatesAutoresizingMaskIntoConstraints = false
        lineViewY.translatesAutoresizingMaskIntoConstraints = false
        
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
            alertView.heightAnchor.constraint(equalToConstant: 250),
            
            messageView.topAnchor.constraint(equalTo: alertView.topAnchor),
            messageView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            messageView.bottomAnchor.constraint(equalTo: lineViewX.topAnchor),
            
            messageLabel.centerXAnchor.constraint(equalTo: messageView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: messageView.centerYAnchor),
            
            lineViewX.topAnchor.constraint(equalTo: messageView.bottomAnchor),
            lineViewX.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            lineViewX.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            lineViewX.bottomAnchor.constraint(equalTo: buttonView.topAnchor),
            lineViewX.heightAnchor.constraint(equalToConstant: 1),
            
            buttonView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: lineViewY.leadingAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 55),
            
            lineViewY.topAnchor.constraint(equalTo: buttonView.topAnchor),
            lineViewY.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor),
            lineViewY.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor),
            lineViewY.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
            lineViewY.widthAnchor.constraint(equalToConstant: 1),
            
            deleteButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor),
            
            cancelButton.widthAnchor.constraint(equalTo: deleteButton.widthAnchor),
            cancelButton.heightAnchor.constraint(equalTo: deleteButton.heightAnchor)
            
        ])
    }
}
