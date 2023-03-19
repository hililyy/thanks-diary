//
//  LoginViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/20.
//

import UIKit

class LoginViewModel {
    
    private var kakao = KakaoLogin()
    private var apple: AppleLogin?
    private var google: GoogleLogin?
    
    var view: PLoginViewModel
    var vc: UIViewController
    
    init(_ view: PLoginViewModel, _ vc: UIViewController) {
        self.view = view
        self.vc = vc
        apple = AppleLogin(view, vc)
        google = GoogleLogin(view, vc)
    }
    
    func setLottie(_ view: UIViewController, lottieView: UIView) {
        LottieManager().setLottie(view, lottieView: lottieView, name: "dot", mode: .loop)
    }
    
    func login(type: LoginType) {
        switch type {
        case .apple:
            print("apple")
            apple?.startAppleLogin()
        case .kakao:
            print("kakao")
            kakao.startKakaoLogin()
            self.view.success(type: .kakao)
        case .google:
            print("google")
            google?.startGoogleLogin()
        case .email:
            print("email")
        case .none:
            print("none")
            self.view.success(type: .none)
        }
    }
}