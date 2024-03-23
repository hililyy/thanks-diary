//
//  ThemeFontView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/18.
//

import UIKit
import SnapKit

final class ThemeFontView: BaseView {
    
    // MARK: - UI components
    
    let fontTitleLabel: UILabel = {
        let label = UILabel()
        label.initLabelUI(text: L10n.fontSet,
                          color: Asset.Color.blackColor.color,
                          font: ResourceManager.instance.getFont(size: 15))
        return label
    }()
    
    private let fontContentView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = Asset.Color.gray5.color.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let fontTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(RadioTVCell.self, forCellReuseIdentifier: RadioTVCell.id)
        return tableView
    }()
    
    // MARK: - UI, Target
    
    override func initSubviews() {
        addSubviews([fontTitleLabel,
                     fontContentView])
        
        fontContentView.addSubview(fontTableView)
    }
    
    override func initConstraints() {
        fontTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.height.equalTo(25)
        }
        
        fontTableView.snp.makeConstraints { make in
            make.top.equalTo(fontContentView.snp.top).offset(5)
            make.left.equalTo(fontContentView.snp.left).offset(5)
            make.right.equalTo(fontContentView.snp.right).offset(-5)
            make.bottom.equalTo(fontContentView.snp.bottom).offset(-5)
            make.height.equalTo(220)
        }
        
        fontContentView.snp.makeConstraints { make in
            make.top.equalTo(fontTitleLabel.snp.bottom).offset(15)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
    }
}
