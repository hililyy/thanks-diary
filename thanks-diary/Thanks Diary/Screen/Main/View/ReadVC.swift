//
//  ReadVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/22.
//

import UIKit

class ReadVC: BaseVC {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titlePaddingLable: PaddingLabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var editBtn: UIButton!
    
    var selectedIndex: Int?
    var parentVC: MainVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    
    func setView() {
        editBtn.layer.cornerRadius = 20
        
        titlePaddingLable.layer.borderWidth = 2
        titlePaddingLable.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
        titlePaddingLable.layer.cornerRadius = 10
        
        contentsTextView.layer.borderWidth = 2
        contentsTextView.layer.borderColor = Color.COLOR_LIGHTGRAYBLUE?.cgColor
        contentsTextView.layer.cornerRadius = 10
        contentsTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0);
    }
    
    func setData() {
        guard let index = selectedIndex else { return }
        
        if let date = parentVC?.viewModel.selectedDate.convertString(format: "yyyy년 M월 d일") {
            titleLabel.text = date + " 감사일기"
        } else {
            titleLabel.text = "오늘의 감사일기"
        }
        
        titlePaddingLable.text = parentVC?.viewModel.selectedDetailData[index].title
        contentsTextView.text = parentVC?.viewModel.selectedDetailData[index].contents
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        back(animated: true)
    }
    
    @IBAction func goDelete(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeletePopupVC") as? DeletePopupVC {
            vc.selectedIndex = selectedIndex
            vc.parentVC = parentVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func goEdit(_ sender: Any) {
        guard let vc =  self.storyboard?.instantiateViewController(identifier: "DetailWriteVC") as? DetailWriteVC else { return }
        vc.updateFlag = true
        vc.selectedIndex = selectedIndex
        vc.parentVC = parentVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
