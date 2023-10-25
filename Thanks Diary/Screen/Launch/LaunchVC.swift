//
//  LaunchVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/11.
//

import UIKit

final class LaunchVC: UIViewController {
    
    // MARK: - Property
    
    @IBOutlet weak var lottieView: UIView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLottie()
        initPasswordIfEmpty()
        initLaunch()
    }
    
    // MARK: - Function
    
    private func initLottie() {
        let goLottie = LottieManager.LottieInfo(vc: self,
                                 lottieView: lottieView,
                                 name: Files.dotJson.name,
                                 speed: 3,
                                 mode: .loop)
        
        LottieManager.instance.setLottie(goLottie)
    }
    
    // 비밀번호 ""으로 설정된 유저 비밀번호 변경(초기화 / 이전버전 앱 오류 해결방안)
    private func initPasswordIfEmpty() {
        let password = UserDefaultManager.instance.password
        
        if password.isEmpty {
            UserDefaultManager.instance.password = Constant.INIT_PASSWORD
        }
    }
    
    private func initLaunch() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            let isReEntry = UserDefaultManager.instance.isReEntryUser
            let isPassword = UserDefaultManager.instance.isPassword
            
            if !isReEntry {
                self.registPageToRoot()
                return
            }
            
            if !isPassword {
                self.registMainToRoot()
                return
            }
            
            self.presentSettingPWVC()
        }
    }
    
    private func presentSettingPWVC() {
        let vc = SettingPWVC()
        vc.homeFlag = true
        vc.modalPresentationStyle = .currentContext
        self.present(vc, animated: true)
    }
}
