//
//  FloatingButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

class FloatingButton: UIView {
    var button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonImage(_ sender: UIImage?) {
        button.setImage(sender, for: .normal)
        button.contentMode = .scaleAspectFit
    }
    
    func setConstraints() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
