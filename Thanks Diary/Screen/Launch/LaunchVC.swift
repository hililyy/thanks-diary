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
        
        initLottie()
        initPassword()
        initLaunch()
    }
    
    // MARK: - Function
    
    private func initLottie() {
        let goLottie = LottieManager.LottieInfo(vc: self,
                                 lottieView: lottieView,
                                 name: Files.dotJson.name,
                                 speed: 3,
                                 mode: .loop)
        
        LottieManager.instance?.setLottie(goLottie)
    }
    
    // 비밀번호 ""으로 설정된 유저 비밀번호 변경(초기화 / 이전버전 앱 오류 해결방안)
    private func initPassword() {
        guard let password = UserDefaultManager.instance?.string(UserDefaultKey.PASSWORD.rawValue) else { return }
        if password.isEmpty {
            UserDefaultManager.instance?.set(Constant.INIT_PASSWORD, key: UserDefaultKey.PASSWORD.rawValue)
        }
    }
    
    private func initLaunch() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            if let isReEntry = UserDefaultManager.instance?.bool(UserDefaultKey.IS_RE_ENTRY_USER.rawValue),
               isReEntry {
                if let isPassword = UserDefaultManager.instance?.bool(UserDefaultKey.IS_PASSWORD.rawValue),
                   isPassword {
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
