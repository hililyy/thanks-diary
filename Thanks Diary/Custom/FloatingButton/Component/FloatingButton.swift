//
//  FloatingButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

final class FloatingButton: BaseView {
    
    // MARK: - Property
    
    var button: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 26
        return button
    }()
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 26
        view.isUserInteractionEnabled = false
        return view
    }()
    
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
            make.edges.equalToSuperview().inset(10)
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
