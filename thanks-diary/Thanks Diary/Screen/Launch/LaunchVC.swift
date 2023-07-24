//
//  LaunchVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/11.
//

import UIKit

class LaunchVC: BaseVC {
    
    @IBOutlet weak var lottieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LottieManager.shared.setLottie(self, lottieView: lottieView, name: "dot", speed: 3, mode: .loop)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            
            if UserDefaultManager.bool(forKey: UserDefaultKey.IS_LOGIN) {
                if !UserDefaultManager.bool(forKey: UserDefaultKey.IS_PASSWORD) {
                    self.setMainToRoot()
                } else {
                    let vc = SettingPWVC()
                    vc.homeFlag = true
                    vc.modalPresentationStyle = .currentContext
                    self.present(vc, animated: true)
                }
            } else {
                self.setPageToRoot()
            }
        }
    }
}
