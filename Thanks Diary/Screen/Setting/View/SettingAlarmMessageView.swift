//
//  SettingAlarmMessageView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/12/13.
//

import UIKit
import SnapKit
import RxSwift

final class SettingAlarmMessageView: BaseView {
    
    // MARK: - UI components
    
    let navigationView = NavigationView(title: L10n.settingName14)
    
    let previewContentsView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray10.color
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 5.0
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowPath = nil
        return view
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.text = L10n.pushWarningMessage
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        return label
    }()
    
    let previewAppIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Image.imgAppIcon.image
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    let previewLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    let previewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = Asset.Color.gray6.color
        return label
    }()
    
    let previewContentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let titleTextFieldLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 16)
        label.text = L10n.title
        label.textColor = Asset.Color.gray1.color
        return label
    }()
    
    let messageTitleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.layer.borderColor = Asset.Color.gray5.color.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 16
        textField.font = ResourceManager.instance.getFont(size: 15)
        textField.addLeftPadding()
        textField.placeholder = L10n.inputTitle
        return textField
    }()
    
    let contentsTextFieldLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 16)
        label.text = L10n.contents
        label.textColor = Asset.Color.gray1.color
        return label
    }()
    
    let messageContentsTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.layer.borderColor = Asset.Color.gray5.color.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 16
        textField.font = ResourceManager.instance.getFont(size: 15)
        textField.addLeftPadding()
        textField.placeholder = L10n.inputContents
        return textField
    }()
    
    let completeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.backgroundColor = ResourceManager.instance.getMainColor()
        button.titleLabel?.font =  ResourceManager.instance.getFont(size: 18)
        button.setTitle(L10n.complete, for: .normal)
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
        return button
    }()
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    override func initTarget() {
        messageTitleTextField.rx.text
            .map { $0?.isEmpty == true ? L10n.pushTitleGeneral : $0 }
            .bind(to: previewTitleLabel.rx.text)
            .disposed(by: disposeBag)

        messageContentsTextField.rx.text
            .map { $0?.isEmpty == true ? L10n.pushContentsGeneral : $0 }
            .bind(to: previewContentsLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func initSubviews() {
        addSubviews([
            navigationView,
            previewContentsView,
            warningLabel,
            titleTextFieldLabel,
            messageTitleTextField,
            contentsTextFieldLabel,
            messageContentsTextField,
            completeButton
        ])
        
        previewContentsView.addSubviews([
            previewAppIconImageView,
            previewLabelStackView
        ])
        previewLabelStackView.addArrangedSubviews([
            previewTitleLabel,
            previewContentsLabel
        ])
    }
    
    override func initConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        previewContentsView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(45)
            make.bottom.equalTo(warningLabel.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
        
        previewAppIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        
        previewLabelStackView.snp.makeConstraints { make in
            make.leading.equalTo(previewAppIconImageView.snp.trailing).offset(10)
            make.trailing.centerY.equalToSuperview()
        }
        
        warningLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(titleTextFieldLabel.snp.top).offset(-40)
        }
        
        titleTextFieldLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.bottom.equalTo(messageTitleTextField.snp.top).offset(-10)
        }
        
        messageTitleTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        contentsTextFieldLabel.snp.makeConstraints { make in
            make.top.equalTo(messageTitleTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(24)
            make.bottom.equalTo(messageContentsTextField.snp.top).offset(-10)
        }
        
        messageContentsTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(messageContentsTextField.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
