//
//  FirstStartVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/17.
//

import UIKit

class FirstStartVC: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtn.layer.cornerRadius = 20
    }
    
    @IBAction func goNext(_ sender: Any) {
        self.showSecondViewController()
    }
    
    func showSecondViewController() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondStartVC") as? SecondStartVC {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true, completion: nil)
        }
    }
}
