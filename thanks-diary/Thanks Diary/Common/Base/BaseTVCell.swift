//
//  BaseTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/18.
//

import UIKit
import Then
import SnapKit

class BaseTVCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        initSubviews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {}
    func initSubviews() {}
    func initConstraints() {}
}
