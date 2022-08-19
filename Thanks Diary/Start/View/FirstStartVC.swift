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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func goNext(_ sender: Any) {
        guard let vc =  storyboard?.instantiateViewController(identifier: "SecondStartVC") as? SecondStartVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
