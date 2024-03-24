//
//  SettingSwitchCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit

final class SettingSwitchTVCell: BaseTVCell, CellIdentifier {
    
    // MARK: - UI components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 17)
        label.textColor = Asset.Color.gray1.color
        return label
    }()
    
    let settingSwitch = UISwitch()
    
    var switchTapHandler: () -> Void = {}
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        settingSwitch.onTintColor = ResourceManager.instance.getMainColor()
        settingSwitch.addTarget { [weak self] _ in
            guard let self else { return }
            
            switchTapHandler()
        }
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        contentView.addSubviews([
            titleLabel,
            settingSwitch
        ])
    }
    
    override func initConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(15)
        }
        
        settingSwitch.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(titleLabel)
        }
    }
}
