//
//  SettingView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/23.
//

import UIKit
import SnapKit

final class SettingView: BaseView {
    
    // MARK: - UI components
    
    let navigationView = NavigationView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(SettingSwitchTVCell.self, forCellReuseIdentifier: SettingSwitchTVCell.id)
        tableView.register(SettingMoreTVCell.self, forCellReuseIdentifier: SettingMoreTVCell.id)
        tableView.register(SettingLabelTVCell.self, forCellReuseIdentifier: SettingLabelTVCell.id)
        tableView.register(SettingCheckTVCell.self, forCellReuseIdentifier: SettingCheckTVCell.id)
        
        tableView.isScrollEnabled = false
        tableView.isPagingEnabled = false
        return tableView
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    // MARK: - Constraint
    
    func setNavigationTitle(title: String) {
        navigationView.setTitleLabelText(title: title)
    }
    
    func initAllFont() {
        navigationView.titleLabel.font = ResourceManager.instance.getFont(size: 22)
        tableView.reloadData()
    }
    
    override func initSubviews() {
        addSubviews([navigationView, tableView])
    }
    
    override func initConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
