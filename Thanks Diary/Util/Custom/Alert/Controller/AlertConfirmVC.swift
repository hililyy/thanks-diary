//
//  AlertConfirmVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/27.
//

import UIKit

final class AlertConfirmVC: BaseVC {
    
    // MARK: - Property
    
    let alertConfirmView = AlertConfirmView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = alertConfirmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        alertConfirmView.okButton.addTarget { _ in
            self.dismissVC()
        }
    }
}
