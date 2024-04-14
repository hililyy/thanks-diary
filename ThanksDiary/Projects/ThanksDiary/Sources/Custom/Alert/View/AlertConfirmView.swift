//
//  AlertConfirmView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/27.
//

import UIKit

final class AlertConfirmView: BaseView {
    
    // MARK: - Property
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 16)
        label.text = L10n.alertErrorMessage
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let messageView = UIView()
    private let buttonView = UIView()
    
    let okButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.ok, for: .normal)
        button.titleLabel?.font = ResourceManager.instance.getFont(size: 17)
        button.backgroundColor = ResourceManager.instance.getMainColor()
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.setTitleColor(Asset.Color.gray1.color, for: .normal)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    private let lineViewX: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray3.color
        return view
    }()
    
    func setText(message: String, okButtonText: String) {
        messageLabel.text = message
        okButton.setTitle(okButtonText, for: .normal)
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            backgroundView,
            alertView
        ])
        
        alertView.addSubviews([
            messageView,
            buttonView,
            lineViewX
        ])
        
        backgroundView.addSubview(backButton)
        messageView.addSubview(messageLabel)
        buttonView.addSubview(okButton)
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
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        okButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(55)
        }
    }
}
