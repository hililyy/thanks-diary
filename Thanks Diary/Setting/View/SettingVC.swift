//
//  SettingVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.dataSource = self
        settingTableView.delegate = self
        
    }
    @IBAction func goBack(_ sender: Any) {
        
    }
    

    
}
extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingSwitchCell", for: indexPath) as! SettingSwitchCell
            cell.settingLabel.text = "암호 설정"
            return cell
        case 1:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "알림 설정"
            return cell
        case 2:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "오픈소스 라이선스"
            return cell
        case 3:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingMoreCell", for: indexPath) as! SettingMoreCell
            cell.settingLabel.text = "후원하기"
            return cell
        
        case 4:
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "SettingLabelCell", for: indexPath) as! SettingLabelCell
            cell.settingLabel.text = "앱 버전"
            cell.settingDetailLabel.text = "1.0.0"
            return cell
        default:
            return UITableViewCell.init()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
