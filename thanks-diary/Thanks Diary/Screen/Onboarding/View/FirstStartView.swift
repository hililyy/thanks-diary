//
//  FirstStartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit

final class FirstStartView: UIView {
    var lottieView: UIView = {
        let view = UIView()
        return view
    }()
    
    var lottieView2: UIView = {
        let view = UIView()
        return view
    }()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Font.NANUM_ULTRALIGHT_18
        label.text = """
                    단순히 일기를 작성하는건
                    
                    부정적인 감정에 집중하기 쉬워요.
                    
                    감사일기를 작성하면
                    
                    긍정적인 감정에 집중할 수 있어요!
                    """
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubView() {
        addSubview(lottieView)
        addSubview(lottieView2)
        addSubview(messageLabel)
    }
    
    private func setConstraints() {
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView2.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lottieView.heightAnchor.constraint(equalToConstant: 170),
            lottieView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            lottieView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75),
            lottieView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            lottieView2.heightAnchor.constraint(equalToConstant: 150),
            lottieView2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            lottieView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75),
            lottieView2.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
