//
//  SecondStartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit

final class SecondStartView: UIView {
    let lottieView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Font.NANUM_ULTRALIGHT_25
        label.text = "감사일기 작성 방법"
        return label
    }()
    
    private let heartImageView1 = UIImageView(image: UIImage(named: "img_heart"))
    private let heartImageView2 = UIImageView(image: UIImage(named: "img_heart"))
    private let heartImageView3 = UIImageView(image: UIImage(named: "img_heart"))
    private let heartImageView4 = UIImageView(image: UIImage(named: "img_heart"))
    
    private let messageLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.NANUM_ULTRALIGHT_18
        label.text = "긍정문으로 작성해요"
        return label
    }()
    
    private let messageLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.NANUM_ULTRALIGHT_18
        label.text = "작은 일에도 감사한일을 찾아보아요"
        return label
    }()
    
    private let messageLabel3: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.NANUM_ULTRALIGHT_18
        label.text = "매일매일 작성해요"
        return label
    }()
    
    private let messageLabel4: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.NANUM_ULTRALIGHT_18
        label.text = "감사한 일을 항상 생각해요"
        return label
    }()
    
    private lazy var messageImageStackView1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heartImageView1, messageLabel1])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var messageImageStackView2: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heartImageView2, messageLabel2])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var messageImageStackView3: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heartImageView3, messageLabel3])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var messageImageStackView4: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heartImageView4, messageLabel4])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var messageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [messageImageStackView1, messageImageStackView2, messageImageStackView3, messageImageStackView4])
        stackView.spacing = 15
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(lottieView)
        addSubview(titleLabel)
        addSubview(messageStackView)
    }
    
    private func setupConstraints() {
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageStackView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView1.translatesAutoresizingMaskIntoConstraints = false
        heartImageView2.translatesAutoresizingMaskIntoConstraints = false
        heartImageView3.translatesAutoresizingMaskIntoConstraints = false
        heartImageView4.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heartImageView1.widthAnchor.constraint(equalToConstant: 21),
            heartImageView1.heightAnchor.constraint(equalToConstant: 21),
            heartImageView2.widthAnchor.constraint(equalToConstant: 21),
            heartImageView2.heightAnchor.constraint(equalToConstant: 21),
            heartImageView3.widthAnchor.constraint(equalToConstant: 21),
            heartImageView3.heightAnchor.constraint(equalToConstant: 21),
            heartImageView4.widthAnchor.constraint(equalToConstant: 21),
            heartImageView4.heightAnchor.constraint(equalToConstant: 21),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: messageStackView.topAnchor, constant: -100),
            
            messageStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            messageStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            
            lottieView.heightAnchor.constraint(equalToConstant: 130),
            lottieView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            lottieView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            lottieView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
