//
//  BaseVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit
import RxSwift
import RxCocoa
import MessageUI

class BaseVC: UIViewController {

    private var keyboardHeight: CGFloat = 0
    public var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setToast()
        AppearanceCheck()
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func goAppSetting() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }
    }
    
    func exitApp() {
        DispatchQueue.main.async {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(0)
            }
        }
    }
    
    func showErrorPopup() {
        DispatchQueue.main.async {
            let vc = AlertVC()
            vc.alertView.setText(message: "text_error".localized, leftButtonText: "text_inquiry".localized, rightButtonText: "text_exit".localized)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.leftButtonTapHandler = {
                self.sendEmail()
            }
            vc.rightButtonTapHandler = {
                self.exitApp()
            }
            self.present(vc, animated: true)
        }
    }
    
    func AppearanceCheck() {
        guard let appearance = UserDefaults.standard.string(forKey: UserDefaultKey.THEME_MODE) else { return }
        // 다크모드인 상태
        if appearance == "dark" {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
            
            UIApplication.shared.statusBarStyle = .lightContent
            
        // 라이트 모드인 상태
        } else {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
            
            UIApplication.shared.statusBarStyle = .darkContent
            
        }
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

// 이메일
extension BaseVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let compseVC = MFMailComposeViewController()
            compseVC.mailComposeDelegate = self
            compseVC.setToRecipients(["joun406@gmail.com"])
            self.present(compseVC, animated: true, completion: nil)
        }
    }
}
