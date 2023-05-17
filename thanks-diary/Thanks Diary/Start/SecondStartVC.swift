//
//  SecondStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

final class SecondStartVC: UIViewController {
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var lottieView: UIView!
    
    var parentVC: PageVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtn.layer.cornerRadius = 20
        LottieManager.shared.setLottie(self, lottieView: lottieView, name: "writing", mode: .playOnce)
    }
    
    @IBAction func goNext(_ sender: Any) {
        parentVC?.nextPage()
        self.showThirdVC()
    }
}
