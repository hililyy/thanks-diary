//
//  AlertVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/12.
//

import UIKit

final class AlertVC: BaseVC {
    let alertView = AlertView()
    var deleteButtonTapHandler: () -> () = { }
    
    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    private func setTarget() {
        alertView.backButton.addTarget {
            self.popVC()
        }
        
        alertView.cancelButton.addTarget {
            self.popVC()
        }
        
        alertView.deleteButton.addTarget {
            self.deleteButtonTapHandler()
        }
    }
}
