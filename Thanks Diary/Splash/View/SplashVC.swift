//
//  SplashVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/11.
//

import UIKit
import Lottie
import UserNotifications

class SplashVC: UIViewController {
    @IBOutlet weak var lottieView: UIView!
    let userNotificationCenter = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView: AnimationView = .init(name: "dot")
        self.view.addSubview(animationView)
        
        animationView.frame = self.lottieView.bounds
        animationView.center = self.lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 3
        animationView.play()
        animationView.loopMode = .loop
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.requestNotificationAuthorization()
            if LocalDataStore.localDataStore.getNewUserData() == true {
                if LocalDataStore.localDataStore.getPasswordData() == true {
                    self.showPasswordViewController()
                } else {
                    self.showMainViewController()
                }
            } else {
                self.showFirstViewController()
            }
        }
    }
    
    func showFirstViewController() {
        let vc = storyboard!.instantiateViewController(withIdentifier: "FirstStartVC") as! FirstStartVC
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .currentContext
        present(navi, animated:false, completion: nil)
    }
    
    func showMainViewController() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func showPasswordViewController() {
        let vc = storyboard!.instantiateViewController(withIdentifier: "SettingPWVC") as! SettingPWVC
        vc.homeFlag = true
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .currentContext
        present(navi, animated:false, completion: nil)
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            print("success: \(success)")
            LocalDataStore.localDataStore.setPushAlarmAgree(newData: success)
            if let error = error {
                print("Error: \(error)")
            }
//            if self.agreeFlag == true {
//                self.switchFlag = !self.switchFlag
//                LocalDataStore.localDataStore.setPushAlarmData(newData: self.switchFlag)
//            } else {
//                self.alarmTableView.reloadData()
//            }
        }
    }
}
