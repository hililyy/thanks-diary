//
//  SettingUserInfoVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/24.
//

import UIKit
import FirebaseAuth

class SettingUserInfoVC: UIViewController {
    @IBOutlet var userInfoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userInfoTableView.dataSource = self
        self.userInfoTableView.delegate = self
    }
}

extension SettingUserInfoVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = self.userInfoTableView.dequeueReusableCell(withIdentifier: "SettingLabelCell", for: indexPath) as! SettingLabelCell
            cell.settingLabel.text = "이메일"
            cell.settingDetailLabel.text = Auth.auth().currentUser?.email ?? "고객"
            return cell
            
        case 1:
            let cell = self.userInfoTableView.dequeueReusableCell(withIdentifier: "SettingLabelCell", for: indexPath) as! SettingLabelCell
            cell.settingLabel.text = "로그아웃"
            cell.settingDetailLabel.text = ""
            return cell
            
        case 2:
            let cell = self.userInfoTableView.dequeueReusableCell(withIdentifier: "SettingLabelCell", for: indexPath) as! SettingLabelCell
            cell.settingLabel.text = "계정탈퇴"
            cell.settingDetailLabel.text = ""
            
            return cell
        default:
            return UITableViewCell.init()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
