//
//  ThirdStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit
import Lottie


class ThirdStartVC: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var lottieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtn.layer.cornerRadius = 20
        
        let animationView: AnimationView = .init(name: "go")
        self.view.addSubview(animationView)
        
        animationView.frame = self.lottieView.bounds
        animationView.center = self.lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .playOnce
    }
    
    @IBAction func goStart(_ sender: Any) {
        LocalDataStore.localDataStore.setNewUserData(newData: true)
        self.showMainViewController()
    }
    
    func showMainViewController() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
