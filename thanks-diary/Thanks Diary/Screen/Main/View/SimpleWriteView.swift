//
//  SimpleWriteView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/21.
//

import UIKit
import RxSwift
import RxCocoa

final class SimpleWriteView: BaseView {
    
    // MARK: - UI components
    
    private let backgroundView = UIView().then { view in
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    private let containerView = UIView().then { view in
        view.backgroundColor = Color.COLOR_GRAY4
        view.layer.cornerRadius = 10
    }
    
    private var deleteButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_TRASH, for: .normal)
    }
    
    var contentsTextView = UITextView().then { textView in
        textView.backgroundColor = .clear
        textView.font = Font.NANUM_ULTRALIGHT_17
        textView.textColor = Color.COLOR_GRAY1
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
        textView.becomeFirstResponder()
    }
    
    private var textLengthLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_15
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .right
    }
    
    private var buttonView = UIView()
    
    private var completeButton = UIButton(type: .custom).then { button in
        button.setTitle("text_write_complete".localized, for: .normal)
        button.setTitleColor(Color.COLOR_GRAY6, for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_15
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.layer.cornerRadius = 10
    }
    
    private var cancelButton = UIButton(type: .custom).then { button in
        button.setTitle("text_cancel".localized, for: .normal)
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_15
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.5
        button.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
    }
    
    // MARK: - Functions
    
    func setContentsTextView(text: String) {
        contentsTextView.text = text
    }
    
    func setTextLengthLabel(text: String) {
        textLengthLabel.text = text
    }
    
    func isContentsTextViewEmpty() -> Bool {
        return contentsTextView.text.isEmpty
    }
    
    func getContentsTextViewText() -> String {
        return contentsTextView.text
    }
    
    func setCompleteButtonEnable(_ isEnabled: Bool){
        completeButton.isEnabled = isEnabled
    }
    
    func setHiddenForDeleteButton(_ isHidden: Bool) {
        deleteButton.isHidden = isHidden
    }
    
    // MARK: - UI, Target
    
    var completeButtonTapHandler: () -> () = {}
    var cancelButtonTapHandler: () -> () = {}
    var deleteButtonTapHandler: () -> () = {}
    
    override func setTarget() {
        contentsTextView.rx.text
            .map { "\($0?.count ?? 0)/23" }
            .bind(to: textLengthLabel.rx.text)
            .disposed(by: disposeBag)
        
        completeButton.addTarget { _ in
            self.completeButtonTapHandler()
        }
        
        cancelButton.addTarget { _ in
            self.cancelButtonTapHandler()
        }
        
        deleteButton.addTarget { _ in
            self.deleteButtonTapHandler()
        }
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([backgroundView, containerView])
        containerView.addSubviews([deleteButton, contentsTextView, textLengthLabel, buttonView])
        buttonView.addSubviews([completeButton, cancelButton])
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(15)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(220)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(9)
            make.right.equalTo(containerView.snp.right).offset(-9)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        contentsTextView.snp.makeConstraints { make in
            make.left.equalTo(containerView.snp.left).offset(18)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(70)
        }
        
        textLengthLabel.snp.makeConstraints { make in
            make.top.equalTo(contentsTextView.snp.bottom).offset(5)
            make.right.equalTo(contentsTextView.snp.right)
            make.bottom.equalTo(buttonView.snp.top).offset(-10)
        }
        
        buttonView.snp.makeConstraints { make in
            make.left.equalTo(contentsTextView.snp.left)
            make.bottom.equalTo(containerView.snp.bottom).offset(-25)
            make.centerX.equalTo(containerView.snp.centerX)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.left.equalTo(buttonView.snp.left)
            make.right.equalTo(completeButton.snp.left).offset(-10)
            make.bottom.equalTo(buttonView.snp.bottom)
            make.width.equalTo(completeButton.snp.width)
            make.height.equalTo(45)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.right.equalTo(buttonView.snp.right)
            make.bottom.equalTo(buttonView.snp.bottom)
            make.width.equalTo(cancelButton.snp.width)
            make.height.equalTo(cancelButton.snp.height)
        }
    }
}
