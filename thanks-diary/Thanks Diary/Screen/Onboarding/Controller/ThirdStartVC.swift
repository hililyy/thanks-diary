//
//  ThirdStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

final class ThirdStartVC: BaseVC {
    
    // MARK: - Property
    
    private let thirdStartView = ThirdStartView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = thirdStartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLottie()
    }
    
    private func setLottie() {
        LottieManager.instance?.setLottie(self, lottieView: thirdStartView.lottieView, name: "go", mode: .playOnce)
    }
}
