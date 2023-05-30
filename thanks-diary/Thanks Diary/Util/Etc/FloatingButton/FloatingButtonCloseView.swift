//
//  FloatingButtonCloseView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

class FloatingButtonCloseView: UIView {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        return view
    }()
    
    lazy var backgroundButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    var plusButton: FloatingButton = {
        let button = FloatingButton()
        button.setButtonImage(UIImage(named: "ic_pencil") ?? .add)
        button.setButtonBackgroundColor(Color.COLOR_LIGHTGRAYBLUE)
        button.setView()
        return button
    }()
    
    var detailButton: FloatingButton = {
        let button = FloatingButton()
        button.setButtonImage(UIImage(named: "ic_detail_write") ?? .remove)
        button.setButtonBackgroundColor(.white)
        button.setView()
        return button
    }()
    
    var simpleButton: FloatingButton = {
        let button = FloatingButton()
        button.setButtonImage(UIImage(named: "ic_simple_write") ?? .actions)
        button.setButtonBackgroundColor(.white)
        button.setView()
        return button
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.font = Font.NANUM_13
        label.textAlignment = .right
        return label
    }()
    
    var simpleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.NANUM_13
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDetailLabel(label: String) {
        detailLabel.text = label
    }
    
    func setSimpleLabel(label: String) {
        simpleLabel.text = label
    }
    
    func setConstraints() {
        addSubview(backgroundView)
        addSubview(backgroundButton)
        addSubview(plusButton)
        addSubview(detailButton)
        addSubview(simpleButton)
        addSubview(detailLabel)
        addSubview(simpleLabel)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        simpleButton.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        simpleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backgroundButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundButton.topAnchor.constraint(equalTo: topAnchor),
            backgroundButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            plusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            plusButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            plusButton.widthAnchor.constraint(equalToConstant: 52),
            plusButton.heightAnchor.constraint(equalToConstant: 52),
            
            detailButton.centerXAnchor.constraint(equalTo: plusButton.centerXAnchor),
            detailButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor, constant: -80),
            detailButton.widthAnchor.constraint(equalToConstant: 52),
            detailButton.heightAnchor.constraint(equalToConstant: 52),
            
            simpleButton.centerXAnchor.constraint(equalTo: plusButton.centerXAnchor),
            simpleButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor, constant: -160),
            simpleButton.widthAnchor.constraint(equalToConstant: 52),
            simpleButton.heightAnchor.constraint(equalToConstant: 52),
            
            detailLabel.centerYAnchor.constraint(equalTo: detailButton.centerYAnchor),
            detailLabel.rightAnchor.constraint(equalTo: detailButton.leftAnchor, constant: -10),
            simpleLabel.centerYAnchor.constraint(equalTo: simpleButton.centerYAnchor),
            simpleLabel.rightAnchor.constraint(equalTo: simpleButton.leftAnchor, constant: -10)
        ])
    }
}
