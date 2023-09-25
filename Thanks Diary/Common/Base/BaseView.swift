//
//  BaseView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/18.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class BaseView: UIView {
    
    public var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initTarget()
        initSubviews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func initUI() {}
    func initTarget() {}
    func initSubviews() {}
    func initConstraints() {}
    
    func initKeyboardNotification() {
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
    
    @objc func keyboardWillShow(_ notification: Notification) {}
    @objc func keyboardWillHide() {}
}
