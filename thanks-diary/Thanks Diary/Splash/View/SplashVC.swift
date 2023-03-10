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
        setLottie()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.requestNotificationAuthorization()
            if LocalDataStore.localDataStore.getOAuthType() != "" {
                if LocalDataStore.localDataStore.getPasswordData() {
                    self.showPasswordVC()
                } else {
                    self.showMainVC()
                }
            } else {
                self.showLoginVC()
            }
        }
    }
    
    func setLottie() {
        let animationView: AnimationView = .init(name: "dot")
        self.view.addSubview(animationView)
        
        animationView.frame = self.lottieView.bounds
        animationView.center = self.lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 3
        animationView.play()
        animationView.loopMode = .loop
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            print("success: \(success)")
            LocalDataStore.localDataStore.setPushAlarmAgree(newData: success)
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
}
