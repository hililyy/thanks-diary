//
//  UIViewController.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import UIKit

extension UIViewController {
    
    // 시작하기(온보딩) 화면 루트 뷰로 설정
    func setPageToRoot() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(PageNC())
    }
    
    // 메인화면 루트 뷰로 설정
    func setMainToRoot() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainNC())
    }
    
    // 네비게이션 뒤로가기
    func popVC(isAnimated: Bool = true) {
        navigationController?.popViewController(animated: isAnimated)
    }
    
    // 프리젠트 뒤로가기
    func dismissVC(isAnimated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(animated: isAnimated) {
            completion?()
        }
    }
    
    // 현재 화면의 rootVC 까지 뷰 제거
    func dismissToRootVC() {
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
