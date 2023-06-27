//
//  BaseVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit

class BaseVC: UIViewController {

    public var backEventHandler: () -> () = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        backEventHandler()
    }
    
    func back(animated: Bool, completion: (() -> ())? = nil) {
        if isModal {
            self.dismiss(animated: animated)
        } else {
            if let nav = navigationController {
                nav.popViewController(animated: animated)
            }
        }
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
}

extension BaseVC: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
