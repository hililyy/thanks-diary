//
//  SettingUserInfoVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/24.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingUserInfoVC: UIViewController {
    @IBOutlet var userInfoTableView: UITableView!
    let settingModel = SettingModel.model
    var settingUserinfoView: SettingUserInfoView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initalize() {
        settingUserinfoView = SettingUserInfoView(self)
        self.userInfoTableView.dataSource = settingUserinfoView
        self.userInfoTableView.delegate = settingUserinfoView
    }
}
