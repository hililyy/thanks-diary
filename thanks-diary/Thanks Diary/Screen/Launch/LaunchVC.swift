//
//  LaunchVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/11.
//

import UIKit

final class LaunchVC: BaseVC {
    
    // MARK: - Property
    
    @IBOutlet weak var lottieView: UIView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLottie()
        setPasswordInit()
        setLaunch()
    }
    
    // MARK: - Function
    
    private func setLottie() {
        LottieManager.shared.setLottie(self, lottieView: lottieView, name: "dot", speed: 3, mode: .loop)
    }
    
    // 비밀번호 ""으로 설정된 유저 비밀번호 변경(초기화)
    private func setPasswordInit() {
        if UserDefaultManager.string(forKey: UserDefaultKey.PASSWORD).isEmpty {
            UserDefaultManager.set("0000", forKey: UserDefaultKey.PASSWORD)
        }
    }
    
    private func setLaunch() {
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
