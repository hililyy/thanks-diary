//
//  FloatingButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

final class FloatingButton: BaseView {
    
    // MARK: - Property
    
    var button = UIButton(type: .custom).then { button in
        button.layer.cornerRadius = 26
    }
    var imageView = UIImageView().then { view in
        view.layer.cornerRadius = 26
        view.isUserInteractionEnabled = false
    }
    
    func setButtonImage(img: UIImage, color: UIColor) {
        imageView.image = img.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = color
        imageView.contentMode = .scaleAspectFit
    }
    
    func setButtonBackgroundColor(_ color: UIColor?) {
        button.backgroundColor = color
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        self.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([button, imageView])
    }
    
    override func initConstraints() {
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
