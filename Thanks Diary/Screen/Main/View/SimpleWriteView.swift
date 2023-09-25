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
        view.backgroundColor = Asset.Color.gray4.color
        view.layer.cornerRadius = 10
    }
    
    let deleteButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icTrash.image, for: .normal)
    }
    
    let contentsTextView = UITextView().then { textView in
        textView.backgroundColor = .clear
        textView.font =  FontFamily.NanumBarunGothic.ultraLight.font(size: 17)
        textView.textColor = Asset.Color.gray1.color
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Asset.Color.lightGrayBlue.color.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
        textView.becomeFirstResponder()
    }
    
    private let textLengthLabel = UILabel().then { label in
        label.font =  FontFamily.NanumBarunGothic.ultraLight.font(size: 15)
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .right
    }
    
    private let buttonView = UIView()
    
    let completeButton = UIButton(type: .custom).then { button in
        button.setTitle(L10n.writeComplete, for: .normal)
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
        button.titleLabel?.font =  FontFamily.NanumBarunGothic.light.font(size: 15)
        button.backgroundColor = Asset.Color.lightGrayBlue.color
        button.layer.cornerRadius = 10
    }
    
    let cancelButton = UIButton(type: .custom).then { button in
        button.setTitle(L10n.cancel, for: .normal)
        button.setTitleColor(Asset.Color.gray1.color, for: .normal)
        button.titleLabel?.font =  FontFamily.NanumBarunGothic.light.font(size: 15)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.5
        button.layer.borderColor = Asset.Color.lightGrayBlue.color.cgColor
    }
    
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
        guard let contents = contentsTextView.text else { return false }
        return contents.isEmpty
    }
    
    // MARK: - UI, Target
    
    var maxCount: Int = 0
    
    func setMaxCount(count: Int) {
        maxCount = count
    }
    
    override func initTarget() {
        contentsTextView.rx.text
            .map { "\($0?.count ?? 0)/\(self.maxCount)" }
            .bind(to: textLengthLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([backgroundView,
                     containerView])
        containerView.addSubviews([deleteButton,
                                   contentsTextView,
                                   textLengthLabel,
                                   buttonView])
        buttonView.addSubviews([completeButton,
                                cancelButton])
    }
    
    override func initConstraints() {
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
