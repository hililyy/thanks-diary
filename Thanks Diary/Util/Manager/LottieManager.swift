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
    
    private static let _instance = LottieManager()
    
    static var instance: LottieManager {
        return _instance
    }
    
    class LottieInfo {
        let vc: UIViewController
        let lottieView: UIView
        let name: String
        let speed: CGFloat
        let mode: LottieLoopMode
        
        init(vc: UIViewController, lottieView: UIView, name: String, speed: CGFloat, mode: LottieLoopMode) {
            self.vc = vc
            self.lottieView = lottieView
            self.name = name
            self.speed = speed
            self.mode = mode
        }
        
        convenience init(vc: UIViewController, lottieView: UIView, name: String, mode: LottieLoopMode) {
            self.init(vc: vc, lottieView: lottieView, name: name, speed: 1, mode: mode)
        }
    }
    
    func setLottie(_ info: LottieInfo) {
        let animationView: LottieAnimationView = .init(name: info.name)
        info.vc.view.addSubview(animationView)
        animationView.setAutoLayout(to: info.lottieView)
        
        animationView.frame = info.lottieView.bounds
        animationView.center = info.lottieView.center
        animationView.contentMode = .scaleAspectFit
        animationView.play(fromProgress: 0.0,
                           toProgress: 1.0,
                           loopMode: .loop) { _ in }
        animationView.loopMode = info.mode
        animationView.animationSpeed = info.speed
    }
}
