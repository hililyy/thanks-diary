//
//  SearchBar.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/12/05.
//

import UIKit
import SnapKit

final class SearchBar: BaseView {
    
    // MARK: - UI components
    
    let textfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.searchMessage
        textField.backgroundColor = Asset.Color.gray11.color
        textField.textColor = Asset.Color.gray1.color
        textField.layer.cornerRadius = 16
        textField.font = ResourceManager.instance.getFont(size: 15)
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icSearch.image, for: .normal)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icBack.image, for: .normal)
        return button
    }()
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([textfield,
                     searchButton,
                     backButton])
    }
    
    override func initConstraints() {
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalTo(textfield)
            make.size.equalTo(42)
        }
        
        textfield.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(backButton.snp.trailing).offset(10)
            make.trailing.equalTo(searchButton.snp.leading).offset(-10)
            make.bottom.equalToSuperview().inset(5)
            make.height.equalTo(40)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(textfield)
            make.size.equalTo(42)
        }
    }
}
