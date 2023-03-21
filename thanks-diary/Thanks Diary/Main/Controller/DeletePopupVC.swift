//
//  DeletePopupVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/22.
//

import UIKit

final class DeletePopupVC: UIViewController {
    let mainModel = MainModel.model
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func goDelete(_ sender: Any) {
        guard let selectedIndex = selectedIndex else { return }
        if mainModel.loginType == LoginType.none {
            mainModel.deleteData(diaryType: .detail, selectedIndex: selectedIndex)
            showDeleteVC()
        } else {
            mainModel.deleteFirebaseData(diaryType: .detail, selectedIndex: selectedIndex) {
                self.showDeleteVC()
            }
        }
    }
}
