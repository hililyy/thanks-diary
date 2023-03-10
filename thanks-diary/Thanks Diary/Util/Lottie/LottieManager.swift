//
//  LottieManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import Lottie

class LottieManager {
    func setLottie(_ vc: UIViewController, lottieView: UIView, name: String, mode: LottieLoopMode) {
        let animationView: AnimationView = .init(name: name)
        vc.view.addSubview(animationView)
        
        animationView.frame = lottieView.bounds
        animationView.center = lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = mode
    }
}
