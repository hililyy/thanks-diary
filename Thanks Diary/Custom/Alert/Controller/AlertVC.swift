//
//  AlertVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/12.
//

import UIKit
import RxSwift
import RxCocoa

final class AlertVC: BaseVC<AlertView> {
    
    // MARK: - Property
    
    var leftButtonTapHandler: () -> Void = {}
    var rightButtonTapHandler: () -> Void = {}
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTarget()
    }
    
    // MARK: - Function
    
    private func initTarget() {
        attachedView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                
                dismissVC()
            })
            .disposed(by: disposeBag)
        
        attachedView.leftButton.addTarget { _ in
            self.dismissVC {
                self.leftButtonTapHandler()
            }
        }
        
        attachedView.rightButton.addTarget { _ in
            self.dismissVC {
                self.rightButtonTapHandler()
            }
        }
    }
}
