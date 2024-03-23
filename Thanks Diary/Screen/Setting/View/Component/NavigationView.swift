//
//  NavigationView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/18.
//

import UIKit
import SnapKit

final class NavigationView: BaseView {
    
    // MARK: - UI components
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icBack.image, for: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 22)
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Functions
    
    func setTitleLabelText(title: String) {
        titleLabel.text = title
    }
    
    convenience init(title: String) {
        self.init()
        titleLabel.text = title
    }
    
    // MARK: - UI, Target
    
    override func initSubviews() {
        addSubviews([backButton,
                     titleLabel])
    }
    
    override func initConstraints() {
        backButton.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(titleLabel.snp.left).offset(-5)
            make.width.equalTo(42)
            make.height.equalTo(42)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(25)
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(snp.bottom)
            make.height.equalTo(30)
        }
    }
}
