//
//  BaseVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit

class BaseVC: UIViewController {

    private var keyboardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func pushVC(name: String, identifier: String, callback: ((UIViewController)->())? = nil) {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setRootVC(name: String, identifier: String, callback: ((UIViewController)->())? = nil) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        pushVC(name: name, identifier: identifier)
    }
    
    func presentErrorPopup() {
        guard let vc = UIStoryboard(name: "Common", bundle: nil).instantiateViewController(withIdentifier: "AlertConfirmVC") as? AlertConfirmVC else { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
}

extension BaseVC: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
