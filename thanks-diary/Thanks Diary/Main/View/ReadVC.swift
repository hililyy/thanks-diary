//
//  ReadVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/22.
//

import UIKit

class ReadVC: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: PaddingLabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var editBtn: UIButton!
    
    var selectedIndex: Int?
    let mainModel = MainModel.model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setText()
    }
    
    func setView() {
        editBtn.layer.cornerRadius = 20
        titleLabel.layer.borderWidth = 2
        titleLabel.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        titleLabel.layer.cornerRadius = 10
        contentsTextView.layer.borderWidth = 2
        contentsTextView.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        contentsTextView.layer.cornerRadius = 10
        contentsTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0);
    }
    
    func setText() {
        guard let index = selectedIndex else { return }
        titleLabel.text = mainModel.longData[index].title
        contentsTextView.text = mainModel.longData[index].contents
        dateLabel.text = "\(mainModel.selectedDate.convertString(format: "yyyy년 M월 d일")) 감사일기"
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goDelete(_ sender: Any) {
        guard let index = selectedIndex else { return }
        showDeletePopupVC(selectedIndex: index)
    }
    
    @IBAction func goEdit(_ sender: Any) {
        showDetailWriteVC(isEdit: true, selectedIndex: self.selectedIndex)
    }
}
