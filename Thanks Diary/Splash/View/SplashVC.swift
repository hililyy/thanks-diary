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
            if LocalDataStore.localDataStore.getNewUserData() == true {
                self.showMainViewController()
            } else {
                self.showFirstViewController()
            }
        }
    }
    
    func showFirstViewController() {
        let vc = storyboard!.instantiateViewController(withIdentifier: "FirstStartVC") as! FirstStartVC
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .currentContext
        present(navi, animated:false, completion: nil)
        return
    }
    
    func showMainViewController() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
