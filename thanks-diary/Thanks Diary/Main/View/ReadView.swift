//
//  ReadView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/22.
//

import UIKit

final class ReadView: NSObject {
    var readVC: ReadVC
    let mainModel = MainModel.model
    
    init(_ readVC: ReadVC) {
        self.readVC = readVC
    }
    
    func setView() {
        readVC.editBtn.layer.cornerRadius = 20
        readVC.titleLabel.layer.borderWidth = 2
        readVC.titleLabel.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        readVC.titleLabel.layer.cornerRadius = 10
        readVC.contentsTextView.layer.borderWidth = 2
        readVC.contentsTextView.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        readVC.contentsTextView.layer.cornerRadius = 10
        readVC.contentsTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0);
    }
    
    func setText() {
        guard let index = readVC.selectedIndex else { return }
        readVC.dateLabel.text = "\(mainModel.selectedDate.convertString(format: "yyyy년 M월 d일")) 감사일기"
        if mainModel.loginType == LoginType.none {
            readVC.titleLabel.text = mainModel.longData[index].title
            readVC.contentsTextView.text = mainModel.longData[index].contents
        } else {
            readVC.titleLabel.text = mainModel.longDiaryDatabyDate[index].title
            readVC.contentsTextView.text = mainModel.longDiaryDatabyDate[index].contents
        }
    }
}
