//
//  MainVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func goSetting(_ sender: Any) {
        showSettingViewController()
    }
    
    func showSettingViewController() {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier:"SettingVC") as? SettingVC else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
