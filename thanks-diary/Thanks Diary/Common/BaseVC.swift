//
//  BaseVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
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
    
    public func pushVC(name: String, identifier: String, callback: ((UIViewController)->())? = nil) {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BaseVC: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true 
  }
}
