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
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var contentsBtn: UIButton!
    var selectedDataDate: String?
    var selectedDataTitle: String?
    var selectedDataContents: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.layer.borderWidth = 2
        titleLabel.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        titleLabel.layer.cornerRadius = 10
        contentsBtn.layer.borderWidth = 2
        contentsBtn.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        contentsBtn.layer.cornerRadius = 10
        
        titleLabel.text = self.selectedDataTitle
        contentsLabel.text = self.selectedDataContents
        dateLabel.text = self.selectedDataDate
        contentsLabel.sizeToFit()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func goDelete(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeletePopupVC") as? DeletePopupVC {
            vc.selectedDataDate = self.selectedDataDate
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func goEdit(_ sender: Any) {
        guard let vc =  self.storyboard?.instantiateViewController(identifier: "WriteVC") as? WriteVC else { return }
        vc.editFlag = true
        vc.titleString = self.selectedDataTitle ?? ""
        vc.contentsString = self.selectedDataContents ?? ""
        vc.todayString = self.selectedDataDate ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 8.0
    @IBInspectable var rightInset: CGFloat = 8.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
}
