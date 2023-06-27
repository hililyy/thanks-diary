//
//  FloatingButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

class FloatingButton: UIView {
    var button: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonImage(_ img: UIImage?) {
        imageView.image = img
        imageView.contentMode = .scaleAspectFit
    }
    
    func setButtonBackgroundColor(_ color: UIColor?) {
        button.backgroundColor = color
    }
    
    func setView() {
        imageView.layer.cornerRadius = 26
        button.layer.cornerRadius = 26
        
        imageView.isUserInteractionEnabled = false
    }
    
    func setConstraints() {
        addSubview(button)
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
