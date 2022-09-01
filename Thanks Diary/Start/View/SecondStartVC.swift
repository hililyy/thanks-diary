//
//  SecondStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit
import Lottie

class SecondStartVC: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var lottieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtn.layer.cornerRadius = 20
        
        let animationView: AnimationView = .init(name: "writing")
        self.view.addSubview(animationView)
        
        animationView.frame = self.lottieView.bounds
        animationView.center = self.lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .playOnce
    }
    
    @IBAction func goNext(_ sender: Any) {
        self.showThirdViewController()
    }
    
    func showThirdViewController() {
        guard let vc =  storyboard?.instantiateViewController(identifier: "ThirdStartVC") as? ThirdStartVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
