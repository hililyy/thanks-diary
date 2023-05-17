//
//  FirstStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

final class FirstStartVC: UIViewController {
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var lottieView2: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var parentVC: PageVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtn.layer.cornerRadius = 20
        LottieManager.shared.setLottie(self, lottieView: lottieView, name: "sun", mode: .loop)
        LottieManager.shared.setLottie(self, lottieView: lottieView, name: "plant", mode: .playOnce)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func goNext(_ sender: Any) {
        parentVC?.nextPage()
        self.showSecondVC()
    }
}
