//
//  LoginVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/19.
//

import UIKit
import Lottie
import GoogleSignIn

class LoginVC: UIViewController {
    @IBOutlet var lottieView: UIView!
    var currentNonce: String?
    var googleSignInButton: GIDSignInButton!
    let model = LoginModel.model
    let viewModel = LoginViewModel.model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLottie()
        setGoogleLogin()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    func goFirstVC() {
        guard let vc =  storyboard?.instantiateViewController(identifier: "FirstStartVC") as? FirstStartVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setLottie() {
        let animationView: AnimationView = .init(name: "dot")
        self.view.addSubview(animationView)
        animationView.frame = self.lottieView.bounds
        animationView.center = self.lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 3
        animationView.play()
        animationView.loopMode = .loop
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
}
