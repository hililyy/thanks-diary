//
//  SecondStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

final class SecondStartVC: BaseVC {
    
    let secondStartView = SecondStartView()
    
    override func loadView() {
        view = secondStartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LottieManager.shared.setLottie(self, lottieView: secondStartView.lottieView, name: "writing", mode: .playOnce)
    }
}
