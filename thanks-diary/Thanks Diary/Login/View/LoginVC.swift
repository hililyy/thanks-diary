//
//  LoginVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/19.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController {
    @IBOutlet var lottieView: UIView!
    var currentNonce: String?
    var googleSignInButton: GIDSignInButton!
    let model = LoginModel.model
    let viewModel = LoginViewModel.model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LottieManager().setLottie(self, lottieView: lottieView, name: "dot", mode: .loop)
        setGoogleLogin()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func goAppleLogin(_ sender: Any) {
        startAppleLogin()
    }
    
    @IBAction func goGoogleLogin(_ sender: Any) {
        startGoogleLogin()
    }
    
    @IBAction func goEmailLogin(_ sender: Any) {
        startEmailLogin()
    }
    
    @IBAction func goKakaoLogin(_ sender: Any) {
        startKakaoLogin()
    }
    
    @IBAction func goStart(_ sender: Any) {
        self.showFirstVC()
        LocalDataStore.localDataStore.setOAuthType(newData: "none")
    }
}
