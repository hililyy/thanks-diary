//
//  AlertConfirmVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/27.
//

import UIKit

class AlertConfirmVC: UIViewController {
    let alertConfirmView = AlertConfirmView()
    
    override func loadView() {
        view = alertConfirmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    private func setTarget() {
        alertConfirmView.okButton.addTarget { [weak self ] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
    }
}
