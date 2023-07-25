//
//  SettingView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/23.
//

import UIKit

final class SettingView: BaseView {
    
    // MARK: - UI components
    
    private var backButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_BACK, for: .normal)
    }
    
    private var topLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_22
        label.textColor = Color.COLOR_GRAY1
        label.text = "text_setting".localized
        label.textAlignment = .center
    }
    
    var tableView = UITableView().then { tableView in
        tableView.rowHeight = 55
        tableView.register(SettingSwitchTVCell.self, forCellReuseIdentifier: SettingSwitchTVCell.id)
        tableView.register(SettingMoreTVCell.self, forCellReuseIdentifier: SettingMoreTVCell.id)
        tableView.register(SettingLabelTVCell.self, forCellReuseIdentifier: SettingLabelTVCell.id)
    }
    
    // MARK: - UI, Target
    
    var backButtonTapHandler: () -> () = {}
    var switchTapHandler: () -> () = {}
    
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func setTarget() {
        backButton.addTarget {
            self.backButtonTapHandler()
        }
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([backButton,
                     topLabel,
                     tableView
        ])
    }
    
    override func setConstraints() {
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
