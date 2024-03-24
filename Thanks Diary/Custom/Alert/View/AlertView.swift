//
//  AlertView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/12.
//

import UIKit

final class AlertView: BaseView {
    
    // MARK: - Property
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray4.color
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 20)
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let messageView = UIView()
    private let buttonView = UIView()
    
    let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = ResourceManager.instance.getFont(size: 17)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        button.setTitleColor(Asset.Color.gray1.color, for: .normal)
        button.accessibilityIdentifier = "button_left_alert"
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = ResourceManager.instance.getFont(size: 17)
        button.backgroundColor = ResourceManager.instance.getMainColor()
        button.layer.cornerRadius = 10
            button.layer.maskedCorners = [.layerMaxXMaxYCorner]
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
        button.accessibilityIdentifier = "button_left_right"
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    private var lineViewX: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray3.color
        return view
    }()
    
    private var lineViewY: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray3.color
        return view
    }()
    
    // MARK: - Function
    
    func setText(message: String, 
                 leftButtonText: String,
                 rightButtonText: String) {
        messageLabel.text = message
        leftButton.setTitle(leftButtonText, for: .normal)
        rightButton.setTitle(rightButtonText, for: .normal)
    }
    
    override func initSubviews() {
        addSubviews([
            backgroundView,
            alertView
        ])
        
        backgroundView.addSubview(backButton)
        
        alertView.addSubview(messageView)
        
        messageView.addSubview(messageLabel)
        
        alertView.addSubviews([
            buttonView,
            lineViewX
        ])
        
        buttonView.addSubviews([
            leftButton,
            rightButton,
            lineViewY
        ])
    }
    
    override func initConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        alertView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.center.equalToSuperview()
            make.height.equalTo(220)
        }

        messageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(lineViewX.snp.top)
        }

        messageLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().inset(10)
        }

        lineViewX.snp.makeConstraints { make in
            make.top.equalTo(messageView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(buttonView.snp.top)
            make.height.equalTo(1)
        }

        buttonView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
        }

        leftButton.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.trailing.equalTo(lineViewY.snp.leading)
            make.height.equalTo(55)
        }

        lineViewY.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(leftButton.snp.trailing)
            make.trailing.equalTo(rightButton.snp.leading)
            make.width.equalTo(1)
        }

        rightButton.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
        }

        leftButton.snp.makeConstraints { make in
            make.size.equalTo(rightButton)
        }
    }
}
