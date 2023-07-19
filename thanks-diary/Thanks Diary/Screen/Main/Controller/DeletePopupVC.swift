//
//  DeletePopupVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/22.
//

import UIKit

class DeletePopupVC: BaseVC {

    var selectedIndex: Int?
    var parentVC: MainVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func goDelete(_ sender: Any) {
        guard let selectedIndex = selectedIndex else { return }
        parentVC?.viewModel.deleteDetailData(selectedIndex: selectedIndex) { result in
            if result {
                self.setRootVC(name: "Main", identifier: "MainVC")
            } else {
                self.dismiss(animated: true) {
                    self.presentErrorPopup()
                }
            }
        }
    }
}
