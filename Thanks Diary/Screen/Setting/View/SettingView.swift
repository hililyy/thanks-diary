//
//  SettingView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/23.
//

import UIKit
import SnapKit
import Then

final class SettingView: BaseView {
    
    // MARK: - UI components
    
    let navigationView = NavigationView()
    
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
        SettingNameModel(title: L10n.settingName6, contents: CommonUtilManager.instance?.appVersion ?? "", type: .label),
        SettingNameModel(title: L10n.settingName10, contents: "", type: .more)
    ]
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
        navigationView.setTitleLabelText(title: L10n.setting)
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([navigationView,
                     tableView
                    ])
    }
    
    override func initConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(20)
            make.left.equalTo(snp.left).offset(10)
            make.right.equalTo(snp.right).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
