//
//  UIViewController.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import UIKit

extension UIViewController {
    func showFirstVC() {
        guard let vc =  storyboard?.instantiateViewController(identifier: "FirstStartVC") as? FirstStartVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSecondVC() {
        guard let vc =  storyboard?.instantiateViewController(identifier: "SecondStartVC") as? SecondStartVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showThirdVC() {
        guard let vc =  storyboard?.instantiateViewController(identifier: "ThirdStartVC") as? ThirdStartVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func showSignupVC() {
//        guard let vc =  storyboard?.instantiateViewController(identifier: "SignupVC") as? SignupVC else { return }
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    func showMainVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
//    func presentLoginVC() {
//        let vc = storyboard!.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//        let navi = UINavigationController(rootViewController: vc)
//        navi.modalPresentationStyle = .currentContext
//        present(navi, animated:false, completion: nil)
//    }
    
//    func showLoginVC() {
//        guard let vc =  storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC else { return }
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
    func showRootLoginVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
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
    
    func showSimpleWriteVC(isEdit: Bool = false, selectedIndex: Int? = nil) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SimpleWriteVC") as? SimpleWriteVC else { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
//        vc.editFlag = isEdit
//        vc.selectedIndex = selectedIndex
//        vc.noneReloadDelegate = self as? any reloadDelegate
//        vc.firebaseReloadDelegate = self as? any reloadFirebaseDelegate
        self.present(vc, animated: true, completion: nil)
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
//            vc.selectedIndex = index
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showDeletePopupVC(selectedIndex: Int) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeletePopupVC") as? DeletePopupVC {
//            vc.selectedIndex = selectedIndex
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func showDetailWriteVC(isEdit: Bool = false, selectedIndex: Int? = nil) {
        guard let vc =  self.storyboard?.instantiateViewController(identifier: "DetailWriteVC") as? DetailWriteVC else { return }
        vc.editFlag = isEdit
//        vc.selectedIndex = selectedIndex
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showDeleteVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
//    func showSettingUserInfoVC() {
//        guard let vc =  storyboard?.instantiateViewController(identifier: "SettingUserInfoVC") as? SettingUserInfoVC else { return }
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
//    func showSettingAlarmVC() {
//        guard let vc =  storyboard?.instantiateViewController(identifier: "SettingAlarmVC") as? SettingAlarmVC else { return }
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    func presentSettingAlarmDetailVC(selectedDate: Date) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingAlarmDetailVC") as? SettingAlarmDetailVC {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.delegate = self as? any SendDataDelegate
            vc.selectedTime = selectedDate
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func showEmailLogin() {
//        guard let vc =  storyboard?.instantiateViewController(identifier: "EmailLoginVC") as? EmailLoginVC else { return }
//        self.navigationController?.pushViewController(vc, animated: true)
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
