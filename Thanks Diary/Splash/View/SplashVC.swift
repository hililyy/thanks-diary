//
//  SplashVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/11.
//

import UIKit
import Lottie

class SplashVC: UIViewController {
    @IBOutlet weak var lottieView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView: AnimationView = .init(name: "dot")
        self.view.addSubview(animationView)
        
        animationView.frame = self.lottieView.bounds
        animationView.center = self.lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 3
        animationView.play()
        animationView.loopMode = .loop
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.showFirstViewController()
        }
    }
    
    func showFirstViewController() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FirstStartVC") as? FirstStartVC {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true, completion: nil)
        }
    }
}
