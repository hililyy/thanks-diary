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
    func dismissVC(isAnimated: Bool = true, completion: (() -> ())? = nil) {
        dismiss(animated: isAnimated) {
            completion?()
        }
    }
    
    // 현재 화면의 rootVC 까지 뷰 제거
    func dismissToRootVC() {
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func presentSettingPWVC() {
        let vc = storyboard!.instantiateViewController(withIdentifier: "SettingPWVC") as! SettingPWVC
        vc.homeFlag = true
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .currentContext
        present(navi, animated:false, completion: nil)
    }
    
    func showSettingPWVC() {
        guard let vc =  storyboard?.instantiateViewController(identifier: "SettingPWVC") as? SettingPWVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSettingVC() {
        guard let vc =  storyboard?.instantiateViewController(identifier: "SettingVC") as? SettingVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentSettingAlarmDetailVC(selectedDate: Date) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingAlarmDetailVC") as? SettingAlarmDetailVC {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.delegate = self as? any SendDataDelegate
            vc.selectedTime = selectedDate
            
            self.present(vc, animated: true, completion: nil)
        }
    }
}
