//
//  FirstStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit
import Lottie

class FirstStartVC: UIViewController {
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var lottieView2: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
//        setLottie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func goNext(_ sender: Any) {
        self.goSecondVC()
    }
    
    func setView() {
        self.nextBtn.layer.cornerRadius = 20
    }
    
    func setLottie() {
        let animationView: AnimationView = .init(name: "sun")
        self.view.addSubview(animationView)

        animationView.frame = self.lottieView.bounds
        animationView.center = self.lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        
        let animationView2: AnimationView = .init(name: "plant")
        self.view.addSubview(animationView2)
        
        animationView2.frame = self.lottieView2.bounds
        animationView2.center = self.lottieView2.center
        animationView2.contentMode = .scaleAspectFit
        animationView2.play()
        animationView2.loopMode = .playOnce
    }
    
    func goSecondVC() {
        guard let vc =  storyboard?.instantiateViewController(identifier: "SecondStartVC") as? SecondStartVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
