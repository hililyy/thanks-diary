//
//  DetailWriteView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/21.
//

import UIKit

final class DetailWriteView: BaseView {
    
    // MARK: - UI component
    
    var backButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_BACK, for: .normal)
    }
    
    private var topLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_20
        label.textColor = Color.COLOR_GRAY1
    }
    
    var deleteButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_TRASH, for: .normal)
    }
    
    var completeButton = UIButton(type: .custom).then { button in
        button.setTitle("text_complete".localized, for: .normal)
        button.setTitleColor(Color.COLOR_GRAY6, for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_15
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.layer.cornerRadius = 10
    }
    
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [deleteButton]).then { stackView in
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    private let contentScrollView = UIScrollView().then { scrollView in
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
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
    
    var titleTextView = UITextView().then { textView in
        textView.font = Font.NANUM_ULTRALIGHT_17
        textView.textColor = Color.COLOR_GRAY1
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 2
        textView.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
    private var contentsTextView = UITextView().then { textView in
        textView.backgroundColor = .clear
        textView.font = Font.NANUM_ULTRALIGHT_17
        textView.textColor = Color.COLOR_GRAY1
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 2
        textView.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
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
        guard let title = titleTextView.text,
              let contents = contentsTextView.text else { return false}

        return title.isEmpty || contents.isEmpty ? true : false
    }
    
    func getTitleText() -> String {
        guard let title = titleTextView.text else { return "" }
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
        titleTextView.text = titleText
        contentsTextView.text = contentsText
    }
    
    // 키보드 나타났을 때
    override func keyboardWillShow(_ notification: Notification) {
        buttonStackView.removeAllSubViews()
        buttonStackView.addArrangedSubview(completeButton)
        
        setTitleTextViewIsScrolled()
        
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.size.height, right: 0.0)
        contentScrollView.contentInset = contentInset
        contentScrollView.scrollIndicatorInsets = contentInset
        
        if contentsTextView.isFirstResponder {
            contentScrollView.scrollToCenter(height: titleTextView.frame.height + titleLabel.frame.height + 25)
        } else {
            contentScrollView.scrollToTop()
        }
    }
    
    // 키보드 사라질 때
    override func keyboardWillHide() {
        buttonStackView.removeAllSubViews()
        buttonStackView.addArrangedSubview(deleteButton)
        completeHandler()
        
        let contentInset = UIEdgeInsets.zero
        contentScrollView.contentInset = contentInset
        contentScrollView.scrollIndicatorInsets = contentInset
    }
    
    // 텍스트 필드 외부 터치 시 키보드 닫기
    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        titleTextView.resignFirstResponder()
        contentsTextView.resignFirstResponder()
    }
    
    var completeHandler: () -> () = {}
    
    // MARK: - UI, Target
    
    override func configureUI() {
        backgroundColor = Color.COLOR_WHITE
        titleTextView.sizeToFit()
        
        titleTextView.rx
           .didChange
           .subscribe(onNext: { [weak self] in
               self?.setTitleTextViewIsScrolled()
           })
           .disposed(by: disposeBag)
    }
    
    func setTitleTextViewIsScrolled() {
        let size = CGSize(width: self.titleTextView.frame.width, height: .infinity)
        let estimatedSize = self.titleTextView.sizeThatFits(size)
        let isMaxHeight = estimatedSize.height >= 100
        
        guard isMaxHeight != self.titleTextView.isScrollEnabled else { return }
        self.titleTextView.isScrollEnabled = isMaxHeight
        self.titleTextView.reloadInputViews()
        self.setNeedsUpdateConstraints()
    }
    
    override func setTarget() {
        setKeyboardNotification()
        
        // 텍스트 필드 외부 터치 시 키보드 닫기 위한 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        contentScrollView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([backButton,
                     topLabel,
                     buttonStackView,
                     contentScrollView
                    ])
        
        contentScrollView.addSubview(contentView)
        
        contentView.addSubviews([
            titleUnderLineImageView,
            titleLabel,
            titleTextView,
            contentsUnderLineImageView,
            contentsLabel,
            contentsTextView
        ])
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
        
        buttonStackView.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-20)
            make.centerY.equalTo(topLabel.snp.centerY)
        }
        
        completeButton.snp.makeConstraints { make in
            make.width.equalTo(52)
            make.height.equalTo(40)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.width.equalTo(52)
            make.height.equalTo(40)
        }
        
        contentScrollView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(contentScrollView)
            make.width.equalTo(contentScrollView)
            make.height.equalTo(contentScrollView.snp.height).priority(.high)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(35)
            make.height.equalTo(35)
        }
        
        titleUnderLineImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.left.equalTo(titleLabel.snp.left).offset(-8)
            make.bottom.equalTo(titleLabel.snp.bottom)
            make.width.equalTo(55)
        }
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(titleLabel.snp.left)
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentsLabel.snp.top).offset(-15)
            make.height.greaterThanOrEqualTo(44)
            make.height.lessThanOrEqualTo(100)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(35)
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
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
            make.height.greaterThanOrEqualTo(250)
        }
    }
}
