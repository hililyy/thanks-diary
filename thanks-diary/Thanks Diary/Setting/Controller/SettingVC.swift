//
//  SettingVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

class SettingVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    let settingModel = SettingModel.model
    var settingView: SettingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initalize() {
        settingView = SettingView(self)
        settingTableView.dataSource = settingView
        settingTableView.delegate = settingView
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchAlarm(_ sender: Any) {
        settingModel.touchSwitchAlarm() {
            showSettingPWVC()
        }
    }
}
