//
//  SettingUserInfoVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/24.
//

import UIKit
import Firebase

class SettingUserInfoVC: UIViewController {
    @IBOutlet var userInfoTableView: UITableView!
    let model = SettingModel.model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userInfoTableView.dataSource = self
        self.userInfoTableView.delegate = self
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: "\(message) 완료되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { action in
            self.showRootLoginVC()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func setConfirm(message: String) {
        let alert = UIAlertController(title: "알림", message: "\(message)하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "확인", style: .default) { action in
            self.setAlert(message: message)
        })
        self.present(alert, animated: true, completion: nil)
    }
}

extension SettingUserInfoVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.authType == "none" {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = self.userInfoTableView.dequeueReusableCell(withIdentifier: "SettingLabelCell", for: indexPath) as! SettingLabelCell
            cell.settingLabel.text = "이메일"
            if model.authType == "none" {
                cell.settingDetailLabel.text = "로그인 하러가기"
                cell.settingDetailLabel.textColor = .black
            } else {
                cell.settingDetailLabel.text = Auth.auth().currentUser?.email
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // 이메일
            if model.authType == "none" {
                showLoginVC()
            }
        case 1: // 로그아웃
            setConfirm(message: "로그아웃")
            
        case 2: // 계정탈퇴
            setConfirm(message: "계정탈퇴")
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
