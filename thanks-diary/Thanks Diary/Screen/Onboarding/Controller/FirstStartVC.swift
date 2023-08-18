//
//  FirstStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

final class FirstStartVC: BaseVC {
    
    // MARK: - Property
    
    private let firstStartView = FirstStartView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = firstStartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LottieManager.shared.setLottie(self, lottieView: firstStartView.lottieView, name: "sun", mode: .loop)
        LottieManager.shared.setLottie(self, lottieView: firstStartView.lottieView2, name: "plant", mode: .playOnce)
    }
}
