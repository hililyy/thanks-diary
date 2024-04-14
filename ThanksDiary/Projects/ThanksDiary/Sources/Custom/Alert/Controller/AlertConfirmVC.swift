//
//  AlertConfirmVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/27.
//

import UIKit

final class AlertConfirmVC: BaseVC<AlertConfirmView> {
    
    var okButtonTapHandler: () -> Void = {}
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        attachedView.okButton.addTarget { _ in
            self.dismissVC {
                self.okButtonTapHandler()
            }
        }
    }
}
