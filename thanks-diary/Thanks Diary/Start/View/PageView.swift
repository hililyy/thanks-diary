//
//  PageView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/07.
//

import UIKit

class PageView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.addSubview(containerView)
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(progressStackView)
        view.addSubview(nextButton)
        return view
    }()
    
    private lazy var progressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstDotView, secondDotView, thirdDotView])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private var firstDotView: UIView = {
        let dot = UIView()
        return dot
    }()
    
    private var secondDotView: UIView = {
        let dot = UIView()
        return dot
    }()
    
    private var thirdDotView: UIView = {
        let dot = UIView()
        return dot
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = Color.COLOR_GRAYBLUE
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        addSubview(containerView)
    }
    
    private func setConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        progressStackView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            progressStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50),
            progressStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            nextButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            nextButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}
