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
    
    var selectedDataDate: String?
    var selectedDataTitle: String?
    var selectedDataContents: String?
    var selectedDataDateString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        editBtn.layer.cornerRadius = 20
        titleLabel.layer.borderWidth = 2
        titleLabel.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        titleLabel.layer.cornerRadius = 10
        contentsTextView.layer.borderWidth = 2
        contentsTextView.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        contentsTextView.layer.cornerRadius = 10
        contentsTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0);
        titleLabel.text = self.selectedDataTitle
        contentsTextView.text = self.selectedDataContents
        dateLabel.text = self.selectedDataDateString
        
    }
    
    func setTitle() {
        var tmpString = selectedDataDate?.split(separator: "-")
        self.selectedDataDateString = ("\(tmpString![0])년 \(tmpString![1])월 \(tmpString![2])일 감사일기")
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goDelete(_ sender: Any) {
        showDeletePopupVC(date: self.selectedDataDate ?? "")
    }
    
    @IBAction func goEdit(_ sender: Any) {
        showDetailWriteVC(isEdit: true, title: self.selectedDataTitle ?? "", contents: self.selectedDataContents ?? "", today: self.selectedDataDate ?? "")
    }
}

