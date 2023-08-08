//
//  AlertView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/12.
//

import UIKit

final class AlertView: BaseView {
    
    private let backgroundView = UIView().then { view in
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    }
    
    private let alertView = UIView().then { view in
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
    }
    
    private let messageLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_20
        label.text = "text_alert_delete".localized
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .center
    }
    
    private let messageView = UIView()
    private let buttonView = UIView()
    
    let cancelButton = UIButton(type: .custom).then { button in
        button.setTitle("text_calcel".localized, for: .normal)
        button.titleLabel?.font = Font.NANUM_ULTRALIGHT_17
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
    }
    
    let deleteButton = UIButton(type: .custom).then { button in
        button.setTitle("text_delete".localized, for: .normal)
        button.titleLabel?.font = Font.NANUM_ULTRALIGHT_17
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.layer.cornerRadius = 10
            button.layer.maskedCorners = [.layerMaxXMaxYCorner]
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
    }
    
    let backButton = UIButton().then { button in
        button.backgroundColor = .clear
    }
    
    private var lineViewX = UIView().then { view in
        view.backgroundColor = Color.COLOR_GRAY3
    }
    
    private var lineViewY = UIView().then { view in
        view.backgroundColor = Color.COLOR_GRAY3
    }
    
    override func addSubView() {
        addSubviews([backgroundView, alertView])
        backgroundView.addSubview(backButton)
        alertView.addSubview(messageView)
        messageView.addSubview(messageLabel)
        alertView.addSubviews([buttonView, lineViewX])
        buttonView.addSubviews([cancelButton, deleteButton, lineViewY])
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }

        alertView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(220)
        }

        messageView.snp.makeConstraints { make in
            make.top.equalTo(alertView.snp.top)
            make.left.equalTo(alertView.snp.left)
            make.right.equalTo(alertView.snp.right)
            make.bottom.equalTo(lineViewX.snp.top)
        }

        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(messageView.snp.centerX)
            make.centerY.equalTo(messageView.snp.centerY).offset(10)
        }

        lineViewX.snp.makeConstraints { make in
            make.top.equalTo(messageView.snp.bottom)
            make.left.equalTo(alertView.snp.left)
            make.right.equalTo(alertView.snp.right)
            make.bottom.equalTo(buttonView.snp.top)
            make.height.equalTo(1)
        }

        buttonView.snp.makeConstraints { make in
            make.left.equalTo(alertView.snp.left)
            make.right.equalTo(alertView.snp.right)
            make.bottom.equalTo(alertView.snp.bottom)
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.left.equalTo(buttonView.snp.left)
            make.right.equalTo(lineViewY.snp.left)
            make.bottom.equalTo(buttonView.snp.bottom)
            make.height.equalTo(55)
        }

        lineViewY.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.left.equalTo(cancelButton.snp.right)
            make.right.equalTo(deleteButton.snp.left)
            make.bottom.equalTo(buttonView.snp.bottom)
            make.width.equalTo(1)
        }

        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.right.equalTo(buttonView.snp.right)
            make.bottom.equalTo(alertView.snp.bottom)
        }

        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(deleteButton.snp.width)
            make.height.equalTo(deleteButton.snp.height)
        }
    }
}
