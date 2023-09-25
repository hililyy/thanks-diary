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
        LottieManager.instance?.setLottie(self, lottieView: lottieView, name: Files.dotJson.name, speed: 3, mode: .loop)
    }
    
    // 비밀번호 ""으로 설정된 유저 비밀번호 변경(초기화)
    private func setPasswordInit() {
        guard let password = UserDefaultManager.instance?.string(UserDefaultKey.PASSWORD.rawValue) else { return }
        if password.isEmpty {
            UserDefaultManager.instance?.set("0000", key: UserDefaultKey.PASSWORD.rawValue)
        }
    }
    
    private func setLaunch() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            guard let isLogin = UserDefaultManager.instance?.bool(UserDefaultKey.IS_LOGIN.rawValue) else { return }
            if isLogin {
                guard let isPassword = UserDefaultManager.instance?.bool(UserDefaultKey.IS_PASSWORD.rawValue) else { return }
                if isPassword {
                    let vc = SettingPWVC()
                    vc.homeFlag = true
                    vc.modalPresentationStyle = .currentContext
                    self.present(vc, animated: true)
                } else {
                    self.registMainToRoot()
                }
            } else {
                self.registPageToRoot()
            }
        }
    }
}
