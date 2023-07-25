//
//  DetailWriteView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/21.
//

import UIKit

final class DetailWriteView: BaseView {
    
    // MARK: - UI component
    private var backButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_BACK, for: .normal)
    }
    
    private var topLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_20
        label.textColor = Color.COLOR_GRAY1
    }
    
    private var completeButton = UIButton(type: .custom).then { button in
        button.setTitle("text_complete".localized, for: .normal)
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_15
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.layer.cornerRadius = 10
    }
    
    private var titleLabel = UILabel().then { label in
        label.text = "title".localized
        label.font = Font.NANUM_ULTRALIGHT_20
        label.textColor = Color.COLOR_GRAY1
    }
    
    private var contentsLabel = UILabel().then { label in
        label.text = "contents".localized
        label.font = Font.NANUM_ULTRALIGHT_20
        label.textColor = Color.COLOR_GRAY1
    }
    
    private var titleUnderLineImageView = UIImageView().then { imageView in
        imageView.image = Image.IMG_UNDERLINE
    }
    
    private var contentsUnderLineImageView = UIImageView().then { imageView in
        imageView.image = Image.IMG_UNDERLINE
    }
    
    private var titleTextField = UITextField().then { textField in
        textField.font = Font.NANUM_ULTRALIGHT_17
        textField.textColor = Color.COLOR_GRAY1
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
        textField.addLeftPadding()
    }
    
    private var contentsTextView = UITextView().then { textField in
        textField.font = Font.NANUM_ULTRALIGHT_17
        textField.textColor = Color.COLOR_GRAY1
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
        textField.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
    }
    
    // MARK: - Function
    
    func setTopLabelData(date: Date?) {
        if let date = date {
            topLabel.text = ("\(date.convertString(format: "yyyy년 M월 d일")) \("text_thanks_diary".localized)")
        } else {
            topLabel.text = "text_today_thanks_diary".localized
        }
    }
    
    func isEmptyTextField() -> Bool {
        guard let title = titleTextField.text,
              let contents = contentsTextView.text else { return false}

        return title.isEmpty || contents.isEmpty ? true : false
    }
    
    func getTitleText() -> String {
        guard let title = titleTextField.text else { return "" }
        return title
    }
    
    func getContentsText() -> String {
        guard let contents = contentsTextView.text else { return "" }
        return contents
    }
    
    func setCompleteButtonEnable(isOn: Bool) {
        completeButton.isEnabled = isOn
    }
    
    func setTextFieldData(titleText: String, contentsText: String) {
        titleTextField.text = titleText
        contentsTextView.text = contentsText
    }
    
    // MARK: - UI, Target
    
    var backButtonTapHandler: () -> () = {}
    var completeButtonTapHandler: () -> () = {}
    
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func setTarget() {
        backButton.addTarget {
            self.backButtonTapHandler()
        }
        
        completeButton.addTarget {
            self.completeButtonTapHandler()
        }
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([backButton,
                     topLabel,
                     completeButton,
                     titleUnderLineImageView,
                     titleLabel,
                     titleTextField,
                     contentsUnderLineImageView,
                     contentsLabel,
                     contentsTextView])
    }
    
    override func setConstraints() {
        backButton.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(topLabel.snp.left).offset(-5)
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.centerY.equalTo(topLabel.snp.centerY)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(25)
        }
        
        completeButton.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-20)
            make.width.equalTo(52)
            make.height.equalTo(40)
            make.centerY.equalTo(topLabel.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.equalTo(snp.left).offset(35)
            make.height.equalTo(35)
        }
        
        titleUnderLineImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.left.equalTo(titleLabel.snp.left).offset(-8)
            make.bottom.equalTo(titleLabel.snp.bottom)
            make.width.equalTo(55)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(titleLabel.snp.left)
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(contentsLabel.snp.top).offset(-15)
            make.height.equalTo(44)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(35)
            make.height.equalTo(35)
        }
        
        contentsUnderLineImageView.snp.makeConstraints { make in
            make.top.equalTo(contentsLabel.snp.top)
            make.left.equalTo(contentsLabel.snp.left).offset(-8)
            make.bottom.equalTo(contentsLabel.snp.bottom)
            make.width.equalTo(55)
        }
        
        contentsTextView.snp.makeConstraints { make in
            make.top.equalTo(contentsLabel.snp.bottom).offset(3)
            make.left.equalTo(contentsLabel.snp.left)
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    }
}
