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
        setLottie()
    }
    
    private func setLottie() {
        LottieManager.instance?.setLottie(self, lottieView: firstStartView.lottieView, name: Files.sunJson.name, mode: .loop)
        LottieManager.instance?.setLottie(self, lottieView: firstStartView.lottieView2, name: Files.plantJson.name, mode: .playOnce)
    }
}
