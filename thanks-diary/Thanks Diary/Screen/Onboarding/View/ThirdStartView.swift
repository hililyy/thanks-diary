//
//  ThirdStartView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/26.
//

import UIKit

final class ThirdStartView: UIView {
    var lottieView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Font.NANUM_ULTRALIGHT_20
        label.text = """
                    감사일기를 작성하고
                    나다운 하루를 만들어 보세요!
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
        addSubview(messageLabel)
    }
    
    private func setConstraints() {
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: lottieView.topAnchor, constant: -50),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            lottieView.heightAnchor.constraint(equalToConstant: 180),
            lottieView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
            lottieView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75),
            lottieView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}


