//
//  LaunchVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/11.
//

import UIKit

final class LaunchVC: BaseVC {
    
    @IBOutlet weak var lottieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LottieManager.shared.setLottie(self, lottieView: lottieView, name: "launch", toProgress: 0.75, speed: 1.65, mode: .autoReverse)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            AlarmAuth().requestNotificationAuthorization()
            if LocalDataStore.localDataStore.getLoginType() != "" {
                if LocalDataStore.localDataStore.getPasswordData() {
                    self.presentSettingPWVC()
                } else {
                    self.showMainVC()
                }
            } else {
                self.setRootVC(name: "Login", identifier: "LoginVC")
            }
        }
    }
}
