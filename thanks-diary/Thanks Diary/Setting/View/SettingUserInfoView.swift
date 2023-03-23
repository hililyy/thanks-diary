//
//  SettingUserInfoView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/23.
//

import UIKit

final class SettingUserInfoView: NSObject {
    
    private var settingUserInfoVC: SettingUserInfoVC
    private let settingModel = SettingModel.model
    
    init(_ vc: SettingUserInfoVC) {
        self.settingUserInfoVC = vc
    }
}

extension SettingUserInfoView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if settingModel.loginType == LoginType.none {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = settingUserInfoVC.userInfoTableView.dequeueReusableCell(withIdentifier: "SettingLabelCell", for: indexPath) as! SettingLabelCell
            cell.settingLabel.text = "이메일"
            if settingModel.loginType == LoginType.none {
                cell.settingDetailLabel.text = "로그인 하러가기"
                cell.settingDetailLabel.textColor = .black
            } else {
                cell.settingDetailLabel.text = FirebaseLoginManager.shared.getCurrentUserEmail()
            }
            return cell
            
        case 1:
            let cell = settingUserInfoVC.userInfoTableView.dequeueReusableCell(withIdentifier: "SettingLabelCell", for: indexPath) as! SettingLabelCell
            cell.settingLabel.text = "로그아웃"
            cell.settingDetailLabel.text = ""
            return cell
            
        case 2:
            let cell = settingUserInfoVC.userInfoTableView.dequeueReusableCell(withIdentifier: "SettingLabelCell", for: indexPath) as! SettingLabelCell
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
            if settingModel.loginType == LoginType.none {
                settingUserInfoVC.showLoginVC()
            }
        case 1: // 로그아웃
            AlertManager.shared.okCancelAlert(settingUserInfoVC, title: "로그아웃", message: "로그아웃 하시겠습니까?") {
                AlertManager.shared.okAlert(self.settingUserInfoVC, title: "알림", message: "로그아웃이 완료되었습니다.") {
                    self.settingUserInfoVC.showRootLoginVC()
                }
            }
        case 2: // 계정탈퇴
            AlertManager.shared.okCancelAlert(settingUserInfoVC, title: "계정탈퇴", message: "계정탈퇴 하시겠습니까?") {
                FirebaseLoginManager.shared.signOut {
                    AlertManager.shared.okAlert(self.settingUserInfoVC, title: "알림", message: "계정탈퇴가 완료되었습니다.") {
                        self.settingUserInfoVC.showRootLoginVC()
                    }
                }
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
