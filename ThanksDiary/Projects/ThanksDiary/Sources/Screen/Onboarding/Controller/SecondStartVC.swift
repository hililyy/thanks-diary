//
//  SecondStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

final class SecondStartVC: BaseVC<SecondStartView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLottie()
    }
    
    private func initLottie() {
        let writingLottie = LottieManager.LottieInfo(vc: self,
                                                     lottieView: attachedView.lottieView,
                                                     name: Files.writingJson.name,
                                                     mode: .playOnce)
        
        LottieManager.setLottie(writingLottie)
    }
}
