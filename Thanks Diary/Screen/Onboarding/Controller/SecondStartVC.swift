//
//  SecondStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

final class SecondStartVC: BaseVC {
    
    // MARK: - Property
    
    private let secondStartView = SecondStartView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = secondStartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLottie()
    }
    
    private func setLottie() {
        LottieManager.instance?.setLottie(self, lottieView: secondStartView.lottieView, name: Files.writingJson.name, mode: .playOnce)
    }
}
