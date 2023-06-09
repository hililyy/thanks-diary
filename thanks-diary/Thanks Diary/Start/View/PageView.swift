//
//  PageView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/07.
//

import UIKit

class PageView: UIView {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
    
    var firstDotView: UIView = {
        let dot = UIView()
        dot.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        return dot
    }()
    
    var secondDotView: UIView = {
        let dot = UIView()
        dot.backgroundColor = Color.COLOR_GRAY3
        return dot
    }()
    
    var thirdDotView: UIView = {
        let dot = UIView()
        dot.backgroundColor = Color.COLOR_GRAY3
        return dot
    }()
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = Color.COLOR_GRAYBLUE
        button.titleLabel?.font = Font.NANUM_LIGHT_20
        button.setTitle("다음", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addSubView()
        setDot()
        setConstraints()
        
    }
    
    func setDot() {
        firstDotView.layer.cornerRadius = 6
        secondDotView.layer.cornerRadius = 6
        thirdDotView.layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
    }
    
    private func addSubView() {
        addSubview(containerView)
        addSubview(progressStackView)
        addSubview(nextButton)
    }
    
    private func setConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        progressStackView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        firstDotView.translatesAutoresizingMaskIntoConstraints = false
        secondDotView.translatesAutoresizingMaskIntoConstraints = false
        thirdDotView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            
            progressStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            progressStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nextButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 54),
            
            firstDotView.widthAnchor.constraint(equalToConstant: 12),
            firstDotView.heightAnchor.constraint(equalToConstant: 12),
            secondDotView.widthAnchor.constraint(equalToConstant: 12),
            secondDotView.heightAnchor.constraint(equalToConstant: 12),
            thirdDotView.widthAnchor.constraint(equalToConstant: 12),
            thirdDotView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}
