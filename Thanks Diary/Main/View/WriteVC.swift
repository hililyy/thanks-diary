//
//  WriteVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/21.
//

import UIKit

class WriteVC: UIViewController {

    @IBOutlet weak var diaryTitle: UILabel!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var completeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.completeBtn.layer.cornerRadius = 20
        
        self.titleTextfield.layer.cornerRadius = 20
        self.titleTextfield.layer.borderWidth = 1
        self.titleTextfield.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        
        self.contentsTextView.layer.cornerRadius = 20
        self.contentsTextView.layer.borderWidth = 1
        self.contentsTextView.layer.borderColor = UIColor(named: "mainColor")?.cgColor
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func goComplete(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
