//
//  SimpleDiaryTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/04.
//

import UIKit

final class SimpleDiaryTVCell: BaseTVCell, CellIdentifier {
    
    // MARK: - UI components
    
    let dotView: UIView = {
        let view = UIView()
        view.backgroundColor = ResourceManager.instance.getMainColor()
        view.layer.cornerRadius = 3.5
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 17)
        label.textColor = Asset.Color.gray1.color
        label.numberOfLines = 0
        label.accessibilityIdentifier = "label_cell_simple_title"
        return label
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
        accessibilityIdentifier = "SimpleDiaryTVCell"
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            dotView,
            titleLabel
        ])
    }
    
    override func initConstraints() {
        dotView.snp.makeConstraints { make in
            make.size.equalTo(7)
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalTo(dotView.snp.trailing).offset(7)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(5)
        }
    }
}
