//
//  DeletePopupVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/22.
//

import UIKit

class DeletePopupVC: UIViewController {
    let model = MainModel.model
    var selectedDataDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func goCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func goDelete(_ sender: Any) {
        model.deleteDetailData(dateString: self.selectedDataDate ?? "")
        model.longDiaryFlag = false
        LocalDataStore.localDataStore.setTodayDetailData(newData: false)
        showDeleteVC()
    }
}
