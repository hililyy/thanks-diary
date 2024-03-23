//
//  RadioTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/18.
//

import UIKit
import SnapKit

final class RadioTVCell: BaseTVCell, CellIdentifier {
    
    // MARK: - UI components
    
    let outlineCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 3
        view.layer.borderColor = ResourceManager.instance.getMainColor().cgColor
        return view
    }()
    
    let inlineCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        return view
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.initLabelUI(color: .black,
                          font: FontFamily.OwnglyphHaruNanum.regular.font(size: 17))
        return label
    }()
    
    // MARK: - Functions
    
    func changeButtonUI(isSelected: Bool) {
        outlineCircle.layer.borderColor = ResourceManager.instance.getMainColor().cgColor
        inlineCircle.backgroundColor = isSelected ? ResourceManager.instance.getMainColor() : .clear
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    override func initSubviews() {
        contentView.addSubviews([outlineCircle, contentsLabel])
        outlineCircle.addSubview(inlineCircle)
    }
    
    // MARK: - Constraint
    
    override func initConstraints() {
        outlineCircle.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        inlineCircle.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(10)
            make.centerX.equalTo(outlineCircle)
            make.centerY.equalTo(outlineCircle)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.left.equalTo(outlineCircle.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
        }
    }
}
