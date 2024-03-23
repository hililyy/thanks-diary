//
//  DetailWriteView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/21.
//

import UIKit

final class DetailWriteView: BaseView {
    
    // MARK: - UI component
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icBack.image, for: .normal)
        button.accessibilityIdentifier = "button_complete_detail"
        return button
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 20)
        label.textColor = Asset.Color.gray1.color
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icTrash.image, for: .normal)
        button.accessibilityIdentifier = "button_delete_detail"
        return button
    }()
    
    let completeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.complete, for: .normal)
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
        button.titleLabel?.font = ResourceManager.instance.getFont(size: 15)
        button.backgroundColor = ResourceManager.instance.getMainColor()
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.title
        label.font = ResourceManager.instance.getFont(size: 20)
        label.textColor = Asset.Color.gray1.color
        return label
    }()
    
    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.contents
        label.font = ResourceManager.instance.getFont(size: 20)
        label.textColor = Asset.Color.gray1.color
        return label
    }()
    
    private let titleUnderLineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ResourceManager.instance.getUnderLineImage()
        return imageView
    }()
    
    private let contentsUnderLineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ResourceManager.instance.getUnderLineImage()
        return imageView
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = ResourceManager.instance.getFont(size: 17)
        textView.textColor = Asset.Color.gray1.color
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 2
        textView.layer.borderColor = ResourceManager.instance.getMainColor().cgColor
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        textView.accessibilityIdentifier = "textView_title_detail"
        return textView
    }()
    
    lazy var contentsTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = ResourceManager.instance.getFont(size: 17)
        textView.textColor = Asset.Color.gray1.color
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 2
        textView.layer.borderColor = ResourceManager.instance.getMainColor().cgColor
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        textView.accessibilityIdentifier = "textView_contents_detail"
        textView.inputAccessoryView = toolView
        return textView
    }()
    
    lazy var toolView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray7.color
        view.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0)
        return view
    }()
    
    let toolNumberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Asset.Image.icFormNumber.image, for: .normal)
        button.tintColor = Asset.Color.gray14.color
        return button
    }()
    
    let toolDotListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Asset.Image.icFormCircle.image, for: .normal)
        button.tintColor = Asset.Color.gray14.color
        return button
    }()
    
    let toolDashListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Asset.Image.icFormLine.image, for: .normal)
        button.tintColor = Asset.Color.gray14.color
        return button
    }()
    
    let toolInlineButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Asset.Image.icFormInline.image, for: .normal)
        button.tintColor = Asset.Color.gray14.color
        return button
    }()
    
    let toolOutlineButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Asset.Image.icFormOutline.image, for: .normal)
        button.tintColor = Asset.Color.gray14.color
        return button
    }()
    
    lazy var toolStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 50
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    var keyBoardWillShowHandler: () -> Void = {}
    var keyBoardWillHideHandler: () -> Void = {}
    
    // MARK: - Function
    
    func setTopLabelData(date: Date?) {
        if let date {
            topLabel.text = ("\(date.toString(didChangeDateFormat: "yyyy년 M월 d일"))  \(L10n.thanksDiary)")
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
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
        titleTextView.sizeToFit()
        
        titleTextView.rx
           .didChange
           .subscribe(onNext: { [weak self] in
               guard let self else { return }
               
               moveScrollPositionByTitleTextView()
           })
           .disposed(by: disposeBag)
    }
    
    private func moveScrollPositionByTitleTextView() {
        let size = CGSize(width: titleTextView.frame.width, 
                          height: .infinity)
        let estimatedSize = titleTextView.sizeThatFits(size)
        let isMaxHeight = estimatedSize.height >= 100
        
        guard isMaxHeight != titleTextView.isScrollEnabled else { return }
        
        titleTextView.isScrollEnabled = isMaxHeight
        titleTextView.reloadInputViews()
        setNeedsUpdateConstraints()
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
        
        toolStackView.addArrangedSubviews([
            toolNumberButton,
            toolDotListButton,
            toolDashListButton,
            toolInlineButton,
            toolOutlineButton
        ])
        
        toolView.addSubview(toolStackView)
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
        
        toolStackView.snp.makeConstraints { make in
            make.top.equalTo(toolView.snp.top).offset(10)
            make.left.equalTo(toolView.snp.left).offset(20)
            make.right.equalTo(toolView.snp.right).offset(-20)
            make.bottom.equalTo(toolView.snp.bottom).offset(-10)
        }
        
        [toolNumberButton,
         toolDotListButton,
         toolDashListButton,
         toolInlineButton,
         toolOutlineButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(24)
                make.height.equalTo(24)
            }
        }
    }
}

enum TextFieldEmptyType {
    case allEmpty
    case eitherEmpty
    case notAllEmpty
}
