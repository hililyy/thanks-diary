//
//  FloatingButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit
import SnapKit
import Then

class FloatingButton: BaseView {
    var button = UIButton(type: .custom).then {
        $0.layer.cornerRadius = 26
    }
    var imageView = UIImageView().then {
        $0.layer.cornerRadius = 26
        $0.isUserInteractionEnabled = false
    }
    
    func setButtonImage(_ img: UIImage?) {
        imageView.image = img
        imageView.contentMode = .scaleAspectFit
    }
    
    func setButtonBackgroundColor(_ color: UIColor?) {
        button.backgroundColor = color
    }
    
    override func addSubView() {
        addSubview(button)
        addSubview(imageView)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.left.equalTo(snp.left).offset(10)
            make.right.equalTo(snp.right).offset(-10)
            make.bottom.equalTo(snp.bottom).offset(-10)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
    }
}
