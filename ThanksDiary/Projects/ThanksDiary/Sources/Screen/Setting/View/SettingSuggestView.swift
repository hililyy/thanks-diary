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
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icBack.image, for: .normal)
        return button
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 22)
        label.textColor = Asset.Color.gray1.color
        label.text = L10n.settingName9
        label.textAlignment = .center
        return label
    }()
    
    private let noticeView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 219/255, green: 228/255, blue: 255/255, alpha: 0.3)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.suggestNotice
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.register(SettingSuggestTVCell.self,
                           forCellReuseIdentifier: SettingSuggestTVCell.id)
        tableView.register(SettingSuggestReplyTVCell.self,
                           forCellReuseIdentifier: SettingSuggestReplyTVCell.id)
        return tableView
    }()
    
    let loading: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    let writeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icWrite.image, for: .normal)
        return button
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            topView,
            noticeView,
            tableView,
            loading
        ])
        
        noticeView.addSubview(noticeLabel)
        
        topView.addSubviews([
            backButton,
            writeButton,
            topLabel
        ])
    }
    
    override func initConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(noticeView.snp.top)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(44)
            make.centerY.equalTo(topLabel)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(44)
            make.centerY.equalTo(topLabel)
        }
        
        noticeView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(tableView.snp.top).offset(-20)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        loading.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
}
