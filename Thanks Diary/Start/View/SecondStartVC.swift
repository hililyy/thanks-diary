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
        guard let vc =  storyboard?.instantiateViewController(identifier: "ThirdStartVC") as? ThirdStartVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
