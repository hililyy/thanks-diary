//
//  SettingPWVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/20.
//

import UIKit

class SettingPWVC: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var firstImg: UIImageView!
    @IBOutlet weak var secondImg: UIImageView!
    @IBOutlet weak var thirdImg: UIImageView!
    @IBOutlet weak var fourthImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func touchNumberBtn(_ sender: Any) {
    }
    
    @IBAction func touchBackBtn(_ sender: Any) {
    }
    
    @IBAction func touchEnterBtn(_ sender: Any) {
    }
}
