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
        contentView.addSubviews([
            outlineCircle,
            contentsLabel
        ])
        
        outlineCircle.addSubview(inlineCircle)
    }
    
    // MARK: - Constraint
    
    override func initConstraints() {
        outlineCircle.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        inlineCircle.snp.makeConstraints { make in
            make.size.equalTo(10)
            make.center.equalTo(outlineCircle)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(12)
            make.leading.equalTo(outlineCircle.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
