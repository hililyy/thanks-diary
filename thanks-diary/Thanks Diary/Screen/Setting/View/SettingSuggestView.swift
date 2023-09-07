//
//  SettingSuggestView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingSuggestView: BaseView {
    
    // MARK: - UI components
    
    var backButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_BACK, for: .normal)
    }
    
    private var topLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_22
        label.textColor = Color.COLOR_GRAY1
        label.text = "건의 게시판"
        label.textAlignment = .center
    }
    
    var tableView = UITableView().then { tableView in
        tableView.backgroundColor = .clear
        tableView.register(SettingLabelTVCell.self, forCellReuseIdentifier: SettingLabelTVCell.id)
    }
    
    var loading = UIActivityIndicatorView().then { activityIndicator in
        activityIndicator.startAnimating()
    }
    
    var writeButton = UIButton().then { button in
        button.setImage(Image.IC_WRITE, for: .normal)
    }
    
    // MARK: - UI, Target
    
    override func configureUI() {
        backgroundColor = Color.COLOR_WHITE
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([backButton,
                     writeButton,
                     topLabel,
                     tableView,
                     loading
        ])
    }
    
    override func setConstraints() {
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
