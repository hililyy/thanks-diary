//
//  AlertConfirmVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/27.
//

import UIKit

class AlertConfirmVC: BaseVC {
    
    let alertConfirmView = AlertConfirmView()
    
    override func loadView() {
        view = alertConfirmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    private func setTarget() {
        alertConfirmView.okButton.addTarget { _ in
            self.dismissVC()
        }
    }
}
