//
//  AlertVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/12.
//

import UIKit

class AlertVC: BaseVC {
    let alertView = AlertView()
    
    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    private func setTarget() {
        alertView.backButton.addTarget {
            self.back(animated: true)
        }
        
        alertView.cancelButton.addTarget {
            self.back(animated: true)
        }
        
        alertView.deleteButton.addTarget {
            print("삭제버튼 클릭")
        }
    }
}
