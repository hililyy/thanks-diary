//
//  ReadView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/21.
//

import UIKit

final class ReadView: BaseView {
    
    // MARK: - UI components
    
    private var backButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_BACK, for: .normal)
    }
    
    private var topLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_20
        label.textColor = Color.COLOR_GRAY1
    }
    
    private var deleteButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_TRASH, for: .normal)
    }
    
    private var titleLabel = UILabel().then { label in
        label.text = "text_title".localized
        label.font = Font.NANUM_ULTRALIGHT_20
        label.textColor = Color.COLOR_GRAY1
    }
    
    private var contentsLabel = UILabel().then { label in
        label.text = "text_contents".localized
        label.font = Font.NANUM_ULTRALIGHT_20
        label.textColor = Color.COLOR_GRAY1
    }
    
    private var titleUnderLineImageView = UIImageView().then { imageView in
        imageView.image = Image.IMG_UNDERLINE
    }
    
    private var contentsUnderLineImageView = UIImageView().then { imageView in
        imageView.image = Image.IMG_UNDERLINE
    }
    
    private var titleTextLabel = PaddingLabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_17
        label.textColor = Color.COLOR_GRAY1
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 2
        label.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
    }
    
    private var contentsTextView = UITextView().then { textView in
        textView.font = Font.NANUM_ULTRALIGHT_17
        textView.textColor = Color.COLOR_GRAY1
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 2
        textView.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
        textView.isEditable = false
    }
    
    private var updateButton = UIButton(type: .custom).then { button in
        button.setTitle("수정하기", for: .normal)
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_20
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.layer.cornerRadius = 20
    }
    
    // MARK: - Functions
    
    func setTopLabelData(date: Date?) {
        if let date = date {
            topLabel.text = ("\(date.convertString(format: "yyyy년 M월 d일")) \("text_thanks_diary".localized)")
        } else {
            topLabel.text = "text_today_thanks_diary".localized
        }
    }
    
    func setTextFieldData(titleText: String, contentsText: String) {
        titleTextLabel.text = titleText
        contentsTextView.text = contentsText
    }
    
    // MARK: - UI, Target
    
    var backButtonTapHandler: () -> () = {}
    var deleteButtonTapHandler: () -> () = {}
    var updateButtonTapHandler: () -> () = {}
    
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func setTarget() {
        backButton.addTarget {
            self.backButtonTapHandler()
        }
        
        deleteButton.addTarget {
            self.deleteButtonTapHandler()
        }
        
        updateButton.addTarget {
            self.updateButtonTapHandler()
        }
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([backButton,
                     topLabel,
                     deleteButton,
                     titleUnderLineImageView,
                     titleLabel,
                     titleTextLabel,
                     contentsUnderLineImageView,
                     contentsLabel,
                     contentsTextView,
                     updateButton])
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
        
        deleteButton.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-20)
            make.width.equalTo(52)
            make.height.equalTo(52)
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
        
        titleTextLabel.snp.makeConstraints { make in
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
        }
        
        updateButton.snp.makeConstraints { make in
            make.top.equalTo(contentsTextView.snp.bottom).offset(20)
            make.left.equalTo(snp.left).offset(15)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(55)
        }
    }
}
