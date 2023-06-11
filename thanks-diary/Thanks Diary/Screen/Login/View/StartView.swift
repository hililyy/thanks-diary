//
//  StartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/11.
//

import UIKit

final class StartView: UIView {
    
    lazy var buttonView: UIView = {
        let view = UIView()
        return view
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_18
        return button
    }()
    
    var signupButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = Color.COLOR_GRAY3
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_18
        return button
    }()
    
    var noneLoginButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.setTitle("둘러보기", for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_15
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        addView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        backgroundColor = .white
    }
    
    private func addView() {
        buttonView.addSubview(loginButton)
        buttonView.addSubview(signupButton)
        buttonView.addSubview(noneLoginButton)
        addSubview(buttonView)
    }
    
    private func setConstraints() {
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        noneLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            buttonView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            loginButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
            loginButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -15),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            signupButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            signupButton.bottomAnchor.constraint(equalTo: noneLoginButton.topAnchor, constant: -25),
            signupButton.heightAnchor.constraint(equalToConstant: 50),

            noneLoginButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            noneLoginButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor)
        ])
    }
}
