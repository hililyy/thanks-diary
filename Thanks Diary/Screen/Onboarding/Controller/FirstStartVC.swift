//
//  FirstStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

final class FirstStartVC: BaseVC<FirstStartView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLottie()
    }
    
    private func initLottie() {
        let sunLottie = LottieManager.LottieInfo(vc: self,
                                                 lottieView: attachedView.lottieView,
                                                 name: Files.sunJson.name,
                                                 mode: .loop)
        
        let plantLottie = LottieManager.LottieInfo(vc: self,
                                                   lottieView: attachedView.lottieView2,
                                                   name: Files.plantJson.name,
                                                   mode: .playOnce)
        
        LottieManager.instance.setLottie(sunLottie)
        LottieManager.instance.setLottie(plantLottie)
    }
}
