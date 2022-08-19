//
//  SecondStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

class SecondStartVC: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtn.layer.cornerRadius = 20
    }
    
    @IBAction func goNext(_ sender: Any) {
        self.showThirdViewController()
    }
    
    func showThirdViewController() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThirdStartVC") as? ThirdStartVC {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true, completion: nil)
        }
    }
}
