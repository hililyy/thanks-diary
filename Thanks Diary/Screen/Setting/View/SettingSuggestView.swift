//
//  SettingSuggestView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import UIKit

final class SettingSuggestView: BaseView {
    
    // MARK: - UI components
    
    let backButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Icon.icBack.image, for: .normal)
    }
    
    private let topLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_22
        label.textColor = Asset.Color.gray1.color
        label.text = "text_setting_name9".localized
        label.textAlignment = .center
    }
    
    let tableView = UITableView().then { tableView in
        tableView.backgroundColor = .clear
        tableView.register(SettingSuggestTVCell.self, forCellReuseIdentifier: SettingSuggestTVCell.id)
    }
    
    let loading = UIActivityIndicatorView().then { activityIndicator in
        activityIndicator.startAnimating()
    }
    
    let writeButton = UIButton().then { button in
        button.setImage(Asset.Icon.icWrite.image, for: .normal)
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([backButton,
                     writeButton,
                     topLabel,
                     tableView,
                     loading
        ])
    }
    
    override func initConstraints() {
        backButton.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(20)
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.centerY.equalTo(topLabel.snp.centerY)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(25)
            make.centerX.equalTo(snp.centerX)
        }
        
        writeButton.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-20)
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.centerY.equalTo(topLabel.snp.centerY)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(20)
            make.left.equalTo(snp.left).offset(10)
            make.right.equalTo(snp.right).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        loading.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
}
