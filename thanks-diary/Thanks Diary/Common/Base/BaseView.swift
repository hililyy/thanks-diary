//
//  BaseView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/18.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addSubView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {}
    func addSubView() {}
    func setConstraints() {}
}