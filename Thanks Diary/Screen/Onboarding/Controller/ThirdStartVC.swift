//
//  ThirdStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

final class ThirdStartVC: BaseVC<ThirdStartView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLottie()
    }
    
    private func initLottie() {
        let goLottie = LottieManager.LottieInfo(vc: self,
                                                lottieView: attachedView.lottieView,
                                                name: Files.goJson.name,
                                                mode: .playOnce)
        
        LottieManager.instance.setLottie(goLottie)
    }
}
