//
//  SettingSuggestView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import UIKit

final class SettingSuggestView: BaseView {
    
    // MARK: - UI components
    
    private let topView = UIView()
    
    let backButton = UIButton(type: .custom).then { button in
        button.setImage(Asset.Image.icBack.image, for: .normal)
    }
    
    private let topLabel = UILabel().then { label in
        label.font = ResourceManager.instance.getFont(size: 22)
        label.textColor = Asset.Color.gray1.color
        label.text = L10n.settingName9
        label.textAlignment = .center
    }
    
    private let noticeView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 219/255, green: 228/255, blue: 255/255, alpha: 0.3)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let noticeLabel = {
        let label = UILabel()
        label.text = L10n.suggestNotice
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let tableView = UITableView().then { tableView in
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.register(SettingSuggestTVCell.self,
                           forCellReuseIdentifier: SettingSuggestTVCell.id)
        tableView.register(SettingSuggestReplyTVCell.self,
                           forCellReuseIdentifier: SettingSuggestReplyTVCell.id)
    }
    
    let loading = UIActivityIndicatorView().then { activityIndicator in
        activityIndicator.startAnimating()
    }
    
    let writeButton = UIButton().then { button in
        button.setImage(Asset.Image.icWrite.image, for: .normal)
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([topView,
                     noticeView,
                     tableView,
                     loading])
        noticeView.addSubview(noticeLabel)
        topView.addSubviews([backButton,
                             writeButton,
                             topLabel])
    }
    
    override func initConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(noticeView.snp.top)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(topView.snp.left).offset(20)
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.centerY.equalTo(topLabel.snp.centerY)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.top).offset(25)
            make.centerX.equalTo(topView.snp.centerX)
        }
        
        writeButton.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-20)
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.centerY.equalTo(topLabel.snp.centerY)
        }
        
        noticeView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(20)
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(snp.right).offset(-20)
            make.bottom.equalTo(tableView.snp.top).offset(-20)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeView.snp.top).offset(10)
            make.left.equalTo(noticeView.snp.left).offset(10)
            make.right.equalTo(noticeView.snp.right).offset(-10)
            make.bottom.equalTo(noticeView.snp.bottom).offset(-10)
        }
        
        tableView.snp.makeConstraints { make in
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
