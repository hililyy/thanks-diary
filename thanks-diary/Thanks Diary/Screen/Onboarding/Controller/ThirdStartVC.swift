//
//  ThirdStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

final class ThirdStartVC: BaseVC {
    let thirdStartView = ThirdStartView()
    
    override func loadView() {
        view = thirdStartView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        LottieManager.shared.setLottie(self, lottieView: thirdStartView.lottieView, name: "go", mode: .playOnce)
    }
}
