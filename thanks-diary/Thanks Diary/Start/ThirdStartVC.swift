//
//  ThirdStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

final class ThirdStartVC: UIViewController {
    @IBOutlet weak var lottieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LottieManager.shared.setLottie(self, lottieView: lottieView, name: "go", mode: .playOnce)
    }
}
