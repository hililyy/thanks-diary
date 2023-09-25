//
//  SettingView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/23.
//

import UIKit

final class SettingView: BaseView {
    
    // MARK: - UI components
    
    let backButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icBack.image, for: .normal)
    }
    
    private let topLabel = UILabel().then { label in
        label.font =  FontFamily.NanumBarunGothic.ultraLight.font(size: 22)
        label.textColor = Asset.Color.gray1.color
        label.text = L10n.setting
        label.textAlignment = .center
    }
    
    let tableView = UITableView().then { tableView in
        tableView.backgroundColor = .clear
        tableView.register(SettingSwitchTVCell.self, forCellReuseIdentifier: SettingSwitchTVCell.id)
        tableView.register(SettingMoreTVCell.self, forCellReuseIdentifier: SettingMoreTVCell.id)
        tableView.register(SettingLabelTVCell.self, forCellReuseIdentifier: SettingLabelTVCell.id)
    }
    
    // MARK: - UI, Target
    
    let settingTableTitles: [SettingNameModel] = [
        SettingNameModel(title: L10n.settingName1, contents: "", type: ._switch),
        SettingNameModel(title: L10n.settingName2, contents: "", type: .more),
        SettingNameModel(title: L10n.settingName3, contents: "", type: .more),
        SettingNameModel(title: L10n.settingName4, contents: "", type: .more),
        SettingNameModel(title: L10n.settingName5, contents: "", type: .more),
        SettingNameModel(title: L10n.settingName6, contents: CommonUtilManager.instance?.appVersion ?? "", type: .label)
    ]
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([backButton,
                     topLabel,
                     tableView
        ])
    }
    
    override func initConstraints() {
        backButton.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(topLabel.snp.left).offset(-5)
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.centerY.equalTo(topLabel.snp.centerY)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(25)
            make.centerX.equalTo(snp.centerX)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(20)
            make.left.equalTo(snp.left).offset(10)
            make.right.equalTo(snp.right).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
