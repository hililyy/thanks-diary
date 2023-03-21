//
//  SplashVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/11.
//

import UIKit

final class SplashVC: UIViewController {
    
    @IBOutlet weak var lottieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LottieManager().setLottie(self, lottieView: lottieView, name: "dot", mode: .loop)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            AlarmAuth().requestNotificationAuthorization()
            if LocalDataStore.localDataStore.getLoginType() != "" {
                if LocalDataStore.localDataStore.getPasswordData() {
                    self.showPasswordVC()
                } else {
                    self.showMainVC()
                }
            } else {
                self.presentLoginVC()
            }
        }
    }
}