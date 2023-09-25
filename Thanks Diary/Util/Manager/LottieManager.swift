//
//  LottieManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/11.
//

import UIKit
import Lottie

final class LottieManager {
    
    private init() {}
    
    private static var _instance: LottieManager?
    
    public static var instance: LottieManager? {
        return _instance ?? LottieManager()
    }
    
    // 파라미터 개수 너무 많음 -> struct 나 class로 변경 (2개정도만 있는게 좋음)
    func setLottie(_ vc: UIViewController,
                   lottieView: UIView,
                   name: String,
                   fromProgress: AnimationProgressTime = 0.0,
                   toProgress: AnimationProgressTime = 1.0,
                   speed: CGFloat = 1,
                   mode: LottieLoopMode) {
        let animationView: LottieAnimationView = .init(name: name)
        vc.view.addSubview(animationView)
        animationView.setAutoLayout(to: lottieView)
        
        animationView.frame = lottieView.bounds
        animationView.center = lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: .loop) {_ in }
        animationView.loopMode = mode
        animationView.animationSpeed = speed
    }
}
