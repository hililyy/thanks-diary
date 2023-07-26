//
//  BaseVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit
import RxSwift
import RxCocoa

class BaseVC: UIViewController {

    private var keyboardHeight: CGFloat = 0
    public var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setToast()
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

// 토스트 설정
extension BaseVC: UIGestureRecognizerDelegate {
    
    func setToast() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func toast(message: String, withDuration: Double, delay: Double, type: String = "", completion: @escaping () -> ()) {
        let toastLabelWidth: CGFloat = 300
        let toastLabelHeight: CGFloat = 50
        let toastLabelX = (self.view.frame.size.width - toastLabelWidth) / 2
        
        var toastLabelY: CGFloat
        
        if keyboardHeight > 0 {
            toastLabelY = self.view.frame.size.height - keyboardHeight - toastLabelHeight - 50
        } else {
            if type == "top" {
                toastLabelY = 100
            } else {
                toastLabelY = self.view.frame.size.height - toastLabelHeight - 50
            }
        }
        
        let toastLabel = UILabel(frame: CGRect(x: toastLabelX, y: toastLabelY, width: toastLabelWidth, height: toastLabelHeight))
        toastLabel.backgroundColor = Color.COLOR_GRAYBLUE
        toastLabel.textColor = .white
        toastLabel.font = Font.NANUM_LIGHT_15
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15
        toastLabel.clipsToBounds = true
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
            completion()
        })
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        keyboardHeight = keyboardFrame.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        keyboardHeight = 0
    }
    
    func isKeyboardVisible() -> Bool {
        return keyboardHeight > 0
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
