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
        setView()
        setLottie()
    }
    
    @IBAction func goStart(_ sender: Any) {
        self.showMainVC()
    }
    
    func setView() {
        self.nextBtn.layer.cornerRadius = 20
    }
    
    func setLottie() {
        let animationView: AnimationView = .init(name: "go")
        self.view.addSubview(animationView)
        
        animationView.frame = self.lottieView.bounds
        animationView.center = self.lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .playOnce
    }
}
