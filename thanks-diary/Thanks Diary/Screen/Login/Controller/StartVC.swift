//
//  StartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/10.
//

import UIKit

final class StartVC: BaseVC {
    private let startView = StartView()
    
    override func loadView() {
        view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    private func setTarget() {
        startView.loginButton.addTarget { [weak self ] _ in
            guard let self = self else { return }
            self.pushVC(name: "Login", identifier: "LoginVC")
        }
        
        startView.signupButton.addTarget { [weak self ] _ in
            guard let self = self else { return }
            self.pushVC(name: "Login", identifier: "SignupVC")
        }
        
        startView.noneLoginButton.addTarget { [weak self ] _ in
            guard let self = self else { return }
            self.pushVC(name: "Start", identifier: "PageVC")
        }
    }
}
