//
//  SignupView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/12.
//

import UIKit

final class SignupView: UIView {
    
    var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_back"), for: .normal)
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.font = Font.NANUM_LIGHT_18
        return label
    }()
    
    var emailTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "이메일을 입력해 주세요."
        textField.font = Font.NANUM_LIGHT_14
        return textField
    }()
    
    private var emailView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderColor = Color.COLOR_GRAY3?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "비밀번호를 입력해 주세요."
        textField.font = Font.NANUM_LIGHT_14
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var passwordView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderColor = Color.COLOR_GRAY3?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    var rePasswordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "비밀번호를 다시한번 입력해 주세요."
        textField.font = Font.NANUM_LIGHT_14
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var rePasswordView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderColor = Color.COLOR_GRAY3?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    var signupButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_18
        return button
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        addView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        backgroundColor = .white
    }
    
    private func addView() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(containerView)
        
        containerView.addSubview(emailView)
        emailView.addSubview(emailTextField)
        containerView.addSubview(passwordView)
        passwordView.addSubview(passwordTextField)
        containerView.addSubview(rePasswordView)
        rePasswordView.addSubview(rePasswordTextField)
        containerView.addSubview(signupButton)
    }
    
    private func setConstraints() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        emailView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        rePasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        rePasswordView.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 13),
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            
            emailView.topAnchor.constraint(equalTo: containerView.topAnchor),
            emailView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            emailView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            emailView.bottomAnchor.constraint(equalTo: passwordView.topAnchor, constant: -25),
            
            emailTextField.topAnchor.constraint(equalTo: emailView.topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 15),
            emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -15),
            emailTextField.bottomAnchor.constraint(equalTo: emailView.bottomAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            passwordView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            passwordView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            passwordView.bottomAnchor.constraint(equalTo: rePasswordView.topAnchor, constant: -25),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            rePasswordView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            rePasswordView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            rePasswordView.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -35),
            
            rePasswordTextField.topAnchor.constraint(equalTo: rePasswordView.topAnchor),
            rePasswordTextField.leadingAnchor.constraint(equalTo: rePasswordView.leadingAnchor, constant: 15),
            rePasswordTextField.trailingAnchor.constraint(equalTo: rePasswordView.trailingAnchor, constant: -15),
            rePasswordTextField.bottomAnchor.constraint(equalTo: rePasswordView.bottomAnchor),
            rePasswordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            signupButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            signupButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70),
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
        ])
    }
}
