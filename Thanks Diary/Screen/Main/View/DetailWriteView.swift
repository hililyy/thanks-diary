//
//  DetailWriteView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/21.
//

import UIKit

final class DetailWriteView: BaseView {
    
    // MARK: - UI component
    
    let backButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icBack.image, for: .normal)
        button.accessibilityIdentifier = "button_complete_detail"
    }
    
    private let topLabel = UILabel().then { label in
        label.font = ResourceManager.instance.getFont(size: 20)
        label.textColor = Asset.Color.gray1.color
    }
    
    let deleteButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icTrash.image, for: .normal)
        button.accessibilityIdentifier = "button_delete_detail"
    }
    
    let completeButton = UIButton(type: .custom).then { button in
        button.setTitle(L10n.complete, for: .normal)
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
        button.titleLabel?.font = ResourceManager.instance.getFont(size: 15)
        button.backgroundColor = ResourceManager.instance.getMainColor()
        button.layer.cornerRadius = 10
    }
    
    private lazy var buttonStackView = UIStackView().then { stackView in
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    private let contentScrollView = UIScrollView().then { scrollView in
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let titleLabel = UILabel().then { label in
        label.text = L10n.title
        label.font = ResourceManager.instance.getFont(size: 20)
        label.textColor = Asset.Color.gray1.color
    }
    
    private let contentsLabel = UILabel().then { label in
        label.text = L10n.contents
        label.font = ResourceManager.instance.getFont(size: 20)
        label.textColor = Asset.Color.gray1.color
    }
    
    private let titleUnderLineImageView = UIImageView().then { imageView in
        imageView.image = ResourceManager.instance.getUnderLineImage()
    }
    
    private let contentsUnderLineImageView = UIImageView().then { imageView in
        imageView.image = ResourceManager.instance.getUnderLineImage()
    }
    
    let titleTextView = UITextView().then { textView in
        textView.backgroundColor = .clear
        textView.font = ResourceManager.instance.getFont(size: 17)
        textView.textColor = Asset.Color.gray1.color
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 2
        textView.layer.borderColor = ResourceManager.instance.getMainColor().cgColor
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        textView.accessibilityIdentifier = "textView_title_detail"
    }
    
    let contentsTextView = UITextView().then { textView in
        textView.backgroundColor = .clear
        textView.font = ResourceManager.instance.getFont(size: 17)
        textView.textColor = Asset.Color.gray1.color
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 2
        textView.layer.borderColor = ResourceManager.instance.getMainColor().cgColor
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        textView.accessibilityIdentifier = "textView_contents_detail"
    }
    
    // MARK: - Function
    
    func setTopLabelData(date: Date?) {
        if let date {
            topLabel.text = ("\(date.convertString(format: L10n.formatDate1))  \(L10n.thanksDiary)")
        } else {
            topLabel.text = L10n.todayThanksDiary
        }
    }
    
    func getEmptyTextFieldType() -> TextFieldEmptyType {
        let title = titleTextView.text ?? ""
        let contents = contentsTextView.text ?? ""
        
        if title.isEmpty && contents.isEmpty {
            return .allEmpty
        } else if title.isEmpty || contents.isEmpty {
            return .eitherEmpty
        } else {
            return .notAllEmpty
        }
    }
    
    func getTitleText() -> String {
        return titleTextView.text ?? ""
    }
    
    func getContentsText() -> String {
        return contentsTextView.text ?? ""
    }
    
    func setCompleteButtonEnable(isOn: Bool) {
        completeButton.isEnabled = isOn
    }
    
    func setTextFieldData(titleText: String, contentsText: String) {
        titleTextView.text = titleText
        contentsTextView.text = contentsText
    }
    
    func focusTitleTextView() {
        titleTextView.becomeFirstResponder()
    }
    
    func focusTitleTextViewOrContentsTextView() {
        if titleTextView.text.isEmpty {
            titleTextView.becomeFirstResponder()
        } else {
            contentsTextView.becomeFirstResponder()
        }
    }
    
    func dropKeyboard() {
        titleTextView.resignFirstResponder()
        contentsTextView.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        keyBoardWillShowHandler()
        buttonStackView.removeAllSubViews()
        buttonStackView.addArrangedSubview(completeButton)
        
        moveScrollPositionByTitleTextView()
        
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let contentInset = UIEdgeInsets(top: 0.0,
                                        left: 0.0,
                                        bottom: keyboardFrame.size.height,
                                        right: 0.0)
        contentScrollView.contentInset = contentInset
        contentScrollView.scrollIndicatorInsets = contentInset
        
        if contentsTextView.isFirstResponder {
            let positionY = titleTextView.frame.height + titleLabel.frame.height + 25
            contentScrollView.scrollTo(positionY: positionY)
        } else {
            contentScrollView.scrollToTop()
        }
    }
    
    @objc func keyboardWillHide() {
        keyBoardWillHideHandler()
        buttonStackView.removeAllSubViews()
        buttonStackView.addArrangedSubview(deleteButton)
        
        let contentInset = UIEdgeInsets.zero
        contentScrollView.contentInset = contentInset
        contentScrollView.scrollIndicatorInsets = contentInset
    }
    
    var keyBoardWillShowHandler: () -> Void = {}
    var keyBoardWillHideHandler: () -> Void = {}
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
        titleTextView.sizeToFit()
        
        titleTextView.rx
           .didChange
           .subscribe(onNext: { [weak self] in
               
               self?.moveScrollPositionByTitleTextView()
           })
           .disposed(by: disposeBag)
    }
    
    private func moveScrollPositionByTitleTextView() {
        let size = CGSize(width: titleTextView.frame.width, 
                          height: .infinity)
        let estimatedSize = titleTextView.sizeThatFits(size)
        let isMaxHeight = estimatedSize.height >= 100
        
        guard isMaxHeight != titleTextView.isScrollEnabled else { return }
        
        self.titleTextView.isScrollEnabled = isMaxHeight
        self.titleTextView.reloadInputViews()
        self.setNeedsUpdateConstraints()
    }
    
    override func initTarget() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    deinit {
        removeNotification()
    }
    
    func removeNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        buttonStackView.addArrangedSubview(deleteButton)
        
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
    
    override func initConstraints() {
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
            make.top.equalTo(titleLabel.snp.top).offset(15)
            make.left.equalTo(titleLabel.snp.left).offset(-8)
            make.right.equalTo(titleLabel.snp.right).offset(-12)
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
            make.top.equalTo(contentsLabel.snp.top).offset(15)
            make.left.equalTo(contentsLabel.snp.left).offset(-8)
            make.right.equalTo(contentsLabel.snp.right).offset(-12)
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

enum TextFieldEmptyType {
    case allEmpty
    case eitherEmpty
    case notAllEmpty
}
