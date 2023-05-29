//
//  FloatingButtonCloseView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

class FloatingButtonCloseView: UIView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
    
    var plusButton: FloatingButton = {
        let button = FloatingButton()
        button.setButtonImage(UIImage(named: "add_icon_green") ?? .add)
        return button
    }()
    
    var button1: FloatingButton = {
        let button = FloatingButton()
        button.setButtonImage(UIImage(named: "food1") ?? .remove)
        return button
    }()
    
    var button2: FloatingButton = {
        let button = FloatingButton()
        button.setButtonImage(UIImage(named: "food2") ?? .actions)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        addSubview(backgroundView)
        addSubview(plusButton)
        addSubview(button1)
        addSubview(button2)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            plusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            plusButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            plusButton.widthAnchor.constraint(equalToConstant: 40),
            plusButton.heightAnchor.constraint(equalToConstant: 40),
            button1.centerXAnchor.constraint(equalTo: plusButton.centerXAnchor),
            button1.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor, constant: -80),
            button1.widthAnchor.constraint(equalToConstant: 40),
            button1.heightAnchor.constraint(equalToConstant: 40),
            button2.centerXAnchor.constraint(equalTo: plusButton.centerXAnchor),
            button2.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor, constant: -160),
            button2.widthAnchor.constraint(equalToConstant: 40),
            button2.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
