//
//  AlertVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/12.
//

import UIKit

final class AlertVC: BaseVC<AlertView> {
    
    // MARK: - Property
    
    let alertView = AlertView()
    var leftButtonTapHandler: () -> Void = {}
    var rightButtonTapHandler: () -> Void = {}
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        alertView.backButton.addTarget { _ in
            self.dismissVC()
        }
        
        alertView.leftButton.addTarget { _ in
            self.dismissVC {
                self.leftButtonTapHandler()
            }
        }
        
        alertView.rightButton.addTarget { _ in
            self.dismissVC {
                self.rightButtonTapHandler()
            }
        }
    }
}
