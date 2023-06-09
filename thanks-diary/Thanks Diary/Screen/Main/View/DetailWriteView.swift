//
//  DetailWriteView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/22.
//

import UIKit

final class DetailWriteView: NSObject {
    private var detailWriteVC: DetailWriteVC
    private let mainModel = MainModel.model
    
    init(_ detailWriteVC: DetailWriteVC) {
        self.detailWriteVC = detailWriteVC
    }
    
    func setView() {
        detailWriteVC.completeBtn.layer.cornerRadius = 10
        detailWriteVC.titleTextfield.layer.cornerRadius = 20
        detailWriteVC.titleTextfield.layer.borderWidth = 2
        detailWriteVC.titleTextfield.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        detailWriteVC.contentsTextView.layer.cornerRadius = 20
        detailWriteVC.contentsTextView.layer.borderWidth = 2
        detailWriteVC.contentsTextView.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        detailWriteVC.titleTextfield.addLeftPadding()
        detailWriteVC.contentsTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 0)
    }
    
    func setTitle() {
        detailWriteVC.diaryTitle.text = "\(mainModel.selectedDate.convertString(format: "yyyy년 M월 d일")) 감사일기"
        if detailWriteVC.editFlag == true {
            guard let index = detailWriteVC.selectedIndex else { return }
            if mainModel.loginType == LoginType.none {
                detailWriteVC.titleTextfield.text = mainModel.detailData[index].title
                detailWriteVC.contentsTextView.text = mainModel.detailData[index].contents
            } else {
                detailWriteVC.titleTextfield.text = mainModel.detailDiaryDatabyDate[index].title
                detailWriteVC.contentsTextView.text = mainModel.detailDiaryDatabyDate[index].contents
            }
        }
    }
}
