//
//  ReadVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/22.
//

import UIKit

final class ReadVC: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: PaddingLabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var editBtn: UIButton!
    
    var selectedIndex: Int?
    let mainModel = MainModel.model
    var readView : ReadView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    func initalize() {
        readView = ReadView(self)
        readView?.setView()
        readView?.setText()
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
