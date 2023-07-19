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
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(PageVC())
    }
    
//    // 메인화면 루트 뷰로 설정
//    func setMainToRoot() {
//    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainNC())
//    }
    
    func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func dismissVC() {
        dismiss(animated: true)
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
    
    func showDetailWriteVC() {
        guard let vc =  self.storyboard?.instantiateViewController(identifier: "DetailWriteVC") as? DetailWriteVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSettingVC() {
        guard let vc =  storyboard?.instantiateViewController(identifier: "SettingVC") as? SettingVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showReadVC(index: Int) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReadVC") as? ReadVC {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showDeletePopupVC(selectedIndex: Int) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeletePopupVC") as? DeletePopupVC {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func showDetailWriteVC(isEdit: Bool = false, selectedIndex: Int? = nil) {
        guard let vc =  self.storyboard?.instantiateViewController(identifier: "DetailWriteVC") as? DetailWriteVC else { return }
        vc.updateFlag = isEdit
//        vc.selectedIndex = selectedIndex
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showDeleteVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
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

extension UIViewController {

    var isModal: Bool {

        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
