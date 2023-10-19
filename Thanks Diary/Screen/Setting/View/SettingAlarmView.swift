//
//  SettingAlarmView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingAlarmView: BaseView {
    
    // MARK: - UI components
    
    let navigationView = NavigationView()
    
    let tableView = UITableView().then { tableView in
        tableView.backgroundColor = .clear
        tableView.register(SettingSwitchTVCell.self, forCellReuseIdentifier: SettingSwitchTVCell.id)
        tableView.register(SettingLabelTVCell.self, forCellReuseIdentifier: SettingLabelTVCell.id)
    }
    
    // MARK: - UI, Data

    override func initUI() {
        backgroundColor = Asset.Color.white.color
        navigationView.setTitleLabelText(title: L10n.settingAlarm)
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
