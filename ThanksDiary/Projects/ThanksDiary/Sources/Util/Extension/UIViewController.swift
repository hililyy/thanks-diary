//
//  UIViewController.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import UIKit

extension UIViewController {
    func registPageToRoot() {
        let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        scene?.changeRootViewController(PageNC())
    }
    
    func registMainToRoot() {
        let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        scene?.changeRootViewController(MainNC())
    }
    
    func popVC(isAnimated: Bool = true) {
        navigationController?.popViewController(animated: isAnimated)
    }
    
    func popVC(animated: Bool = true,
               completion: @escaping () -> Void) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navigationController?.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func dismissVC(isAnimated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(animated: isAnimated) {
            completion?()
        }
    }
    
    func dismissToRootVC() {
        view.window?.rootViewController?.dismiss(animated: true)
    }
}
