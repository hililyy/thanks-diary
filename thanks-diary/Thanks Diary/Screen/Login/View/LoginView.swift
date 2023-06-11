//
//  LoginView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/11.
//

import UIKit

final class LoginView: UIView {
    
    var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_back"), for: .normal)
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 로그인"
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
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_18
        return button
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var findView: UIView = {
        let view = UIView()
        return view
    }()
    
    var findIdButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.setTitle("아이디 찾기", for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_15
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    var findPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.setTitle("비밀번호 찾기", for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_15
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.COLOR_GRAY3
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
        containerView.addSubview(loginButton)
        addSubview(findView)
        findView.addSubview(findIdButton)
        findView.addSubview(findPasswordButton)
        findView.addSubview(lineView)
    }
    
    private func setConstraints() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        emailView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        findView.translatesAutoresizingMaskIntoConstraints = false
        findIdButton.translatesAutoresizingMaskIntoConstraints = false
        findPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 13),
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70),
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
            passwordView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -35),
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            containerView.bottomAnchor.constraint(equalTo: findView.topAnchor, constant: -20),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            findView.centerXAnchor.constraint(equalTo: centerXAnchor),
            findIdButton.topAnchor.constraint(equalTo: findView.topAnchor),
            findIdButton.leadingAnchor.constraint(equalTo: findView.leadingAnchor),
            findIdButton.trailingAnchor.constraint(equalTo: lineView.leadingAnchor, constant: -10),
            findIdButton.bottomAnchor.constraint(equalTo: findView.bottomAnchor),
            lineView.topAnchor.constraint(equalTo: findView.topAnchor, constant: 5),
            lineView.bottomAnchor.constraint(equalTo: findView.bottomAnchor, constant: -5),
            lineView.widthAnchor.constraint(equalToConstant: 1),
            findPasswordButton.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 10),
            findPasswordButton.topAnchor.constraint(equalTo: findView.topAnchor),
            findPasswordButton.trailingAnchor.constraint(equalTo: findView.trailingAnchor),
            findPasswordButton.bottomAnchor.constraint(equalTo: findView.bottomAnchor)
        ])
    }
}
