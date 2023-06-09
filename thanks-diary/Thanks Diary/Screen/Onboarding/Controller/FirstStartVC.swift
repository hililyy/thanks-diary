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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LottieManager.shared.setLottie(self, lottieView: lottieView, name: "sun", mode: .loop)
        LottieManager.shared.setLottie(self, lottieView: lottieView, name: "plant", mode: .playOnce)
    }
}
