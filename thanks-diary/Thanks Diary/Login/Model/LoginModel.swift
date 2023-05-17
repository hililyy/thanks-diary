//
//  LoginModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/20.
//

import UIKit

final class LoginModel {
    
    private var view: PLoginModel
    private var vc: UIViewController
    
    init(_ view: PLoginModel, _ vc: UIViewController) {
        self.view = view
        self.vc = vc
    }
    
    func setLottie(_ view: UIViewController, lottieView: UIView) {
        LottieManager.shared.setLottie(view, lottieView: lottieView, name: "dot", mode: .loop)
    }
    
    func login(type: LoginType) {
        switch type {
        case .email:
            print("email")
        case .none:
            print("none")
            self.view.success(type: .none)
        }
    }
}
