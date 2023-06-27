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
        alertView.backButton.addTarget { [weak self ] _ in
            guard let self = self else { return }
            self.back(animated: true)
        }
        
        alertView.cancelButton.addTarget { [weak self ] _ in
            guard let self = self else { return }
            self.back(animated: true)
        }
        
        alertView.deleteButton.addTarget { [weak self ] _ in
            guard let self = self else { return }
            print("삭제버튼 클릭")
        }
    }
}
