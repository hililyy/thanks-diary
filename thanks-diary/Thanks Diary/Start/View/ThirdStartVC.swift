//
//  ThirdStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

class ThirdStartVC: UIViewController {
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var lottieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtn.layer.cornerRadius = 20
        LottieManager().setLottie(self, lottieView: lottieView, name: "go", mode: .playOnce)
    }
    
    @IBAction func goStart(_ sender: Any) {
        self.showMainVC()
    }
}
