//
//  StartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/10.
//

import UIKit

class StartVC: BaseVC {

    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var noneLoginButton: UIButton!
    @IBOutlet weak var lottieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        LottieManager.shared.setLottie(self, lottieView: lottieView, name: "heart", toProgress: 0.45, mode: .loop)
    }
    
    func setTarget() {
        loginButton.addTarget { _ in
            self.pushVC(name: "Login", identifier: "LoginVC")
        }
        
        signupButton.addTarget { _ in
            self.pushVC(name: "Login", identifier: "SignupVC")
        }
        
        noneLoginButton.addTarget { _ in
            self.pushVC(name: "Start", identifier: "PageVC")
        }
    }
}
