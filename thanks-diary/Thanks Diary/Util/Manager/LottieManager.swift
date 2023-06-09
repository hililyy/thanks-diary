//
//  LottieManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import Lottie

final class LottieManager {
    
    static let shared = LottieManager()
    private init() { }
    
    func setLottie(_ vc: UIViewController, lottieView: UIView, name: String, fromProgress: AnimationProgressTime = 0.0, toProgress: AnimationProgressTime = 1.0, speed: CGFloat = 1, mode: LottieLoopMode) {
        let animationView: LottieAnimationView = .init(name: name)
        vc.view.addSubview(animationView)
        
        animationView.frame = lottieView.bounds
        animationView.center = lottieView.center
        animationView.contentMode = .scaleAspectFill
        animationView.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: .loop) {_ in }
        animationView.loopMode = mode
        animationView.animationSpeed = speed
    }
}
