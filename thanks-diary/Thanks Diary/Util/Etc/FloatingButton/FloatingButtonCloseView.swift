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
        button.setButtonImage(UIImage(named: "ic_x") ?? .add)
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
    
    var detailLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.font = Font.NANUM_LIGHT_13
        label.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .right
        return label
    }()
    
    var simpleLabel: UILabel = {
        let label = PaddingLabel()
        label.font = Font.NANUM_LIGHT_13
        label.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .right
        return label
    }()
    
    var detailButtonCenterY: NSLayoutConstraint!
    var simpleButtonCenterY: NSLayoutConstraint!
    
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
    
    func setOpenConstraints() {
        detailButtonCenterY.constant = -80
        simpleButtonCenterY.constant = -160
    }
    
    func setCloseConstraints() {
        detailButtonCenterY.constant = 0
        simpleButtonCenterY.constant = 0
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
        
        detailButtonCenterY = detailButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor)
        detailButtonCenterY.isActive = true
        
        simpleButtonCenterY = simpleButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor)
        simpleButtonCenterY.isActive = true
        
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
            plusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            plusButton.widthAnchor.constraint(equalToConstant: 52),
            plusButton.heightAnchor.constraint(equalToConstant: 52),
            
            detailButton.centerXAnchor.constraint(equalTo: plusButton.centerXAnchor),
            detailButton.widthAnchor.constraint(equalToConstant: 52),
            detailButton.heightAnchor.constraint(equalToConstant: 52),
            
            simpleButton.centerXAnchor.constraint(equalTo: plusButton.centerXAnchor),
            simpleButton.widthAnchor.constraint(equalToConstant: 52),
            simpleButton.heightAnchor.constraint(equalToConstant: 52),
            
            detailLabel.centerYAnchor.constraint(equalTo: detailButton.centerYAnchor),
            detailLabel.rightAnchor.constraint(equalTo: detailButton.leftAnchor, constant: -10),
            simpleLabel.centerYAnchor.constraint(equalTo: simpleButton.centerYAnchor),
            simpleLabel.rightAnchor.constraint(equalTo: simpleButton.leftAnchor, constant: -10)
        ])
    }
}
