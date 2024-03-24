//
//  SimpleWriteView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimpleWriteView: BaseView {
    
    // MARK: - UI components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    let backgroundButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray4.color
        view.layer.cornerRadius = 10
        return view
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icTrash.image, for: .normal)
        button.accessibilityIdentifier = "button_delete_simple"
        return button
    }()
    
    let contentsTextView: UITextView = {
        let textView = UITextView()
        textView.font = ResourceManager.instance.getFont(size: 17)
        textView.textColor = Asset.Color.gray1.color
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = ResourceManager.instance.getMainColor().cgColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
        textView.becomeFirstResponder()
        textView.accessibilityIdentifier = "textView_contents_simple"
        return textView
    }()
    
    private let textLengthLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 15)
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .right
        return label
    }()
    
    private let buttonView = UIView()
    
    let completeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.writeComplete, for: .normal)
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
        button.titleLabel?.font =  ResourceManager.instance.getFont(size: 15)
        button.backgroundColor = ResourceManager.instance.getMainColor()
        button.layer.cornerRadius = 10
        button.accessibilityIdentifier = "button_complete_simple"
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.cancel, for: .normal)
        button.setTitleColor(Asset.Color.gray1.color, for: .normal)
        button.titleLabel?.font = ResourceManager.instance.getFont(size: 15)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.5
        button.layer.borderColor = ResourceManager.instance.getMainColor().cgColor
        return button
    }()
    
    var maxCount: Int = 0
    private var containerViewBottomConstraint: Constraint?
    
    // MARK: - Functions
    
    func setContentsTextView(text: String) {
        contentsTextView.text = text
    }
    
    func isContentsTextViewEmpty() -> Bool {
        return contentsTextView.text.isEmpty
    }
    
    func getContentsTextViewText() -> String {
        return contentsTextView.text
    }
    
    func setCompleteButtonEnable(_ isEnabled: Bool) {
        completeButton.isEnabled = isEnabled
    }
    
    func setHiddenForDeleteButton(_ isHidden: Bool) {
        deleteButton.isHidden = isHidden
    }
    
    func isEmptyTextField() -> Bool {
        return contentsTextView.text.isEmpty
    }
    
    func setMaxCount(count: Int) {
        maxCount = count
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            updateContentsViewBottomConstraint(constant: -(keyboardSize.height))
        }
    }
    
    func updateContentsViewBottomConstraint(constant: CGFloat) {
        AnimationManager.animationCurveEaseInOut {
            self.containerViewBottomConstraint?.update(offset: constant)
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - UI, Target
    
    override func initTarget() {
        contentsTextView.rx.text
            .map { "\($0?.count ?? 0)/\(self.maxCount)" }
            .bind(to: textLengthLabel.rx.text)
            .disposed(by: disposeBag)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            backgroundView,
            backgroundButton,
            containerView
        ])
        
        containerView.addSubviews([
            deleteButton,
            contentsTextView,
            textLengthLabel,
            buttonView
        ])
        
        buttonView.addSubviews([
            completeButton,
            cancelButton
        ])
    }
    
    override func initConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            containerViewBottomConstraint = make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-200).constraint
            make.height.equalTo(220)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(9)
            make.size.equalTo(44)
        }
        
        contentsTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
        
        textLengthLabel.snp.makeConstraints { make in
            make.top.equalTo(contentsTextView.snp.bottom).offset(5)
            make.trailing.equalTo(contentsTextView)
            make.bottom.equalTo(buttonView.snp.top).offset(-10)
        }
        
        buttonView.snp.makeConstraints { make in
            make.leading.equalTo(contentsTextView)
            make.bottom.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.trailing.equalTo(completeButton.snp.leading).offset(-10)
            make.width.equalTo(completeButton)
            make.height.equalTo(45)
        }
        
        completeButton.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
            make.size.equalTo(cancelButton)
        }
    }
}
