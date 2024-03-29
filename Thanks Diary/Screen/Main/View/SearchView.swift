//
//  SearchView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/12/05.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchView: BaseView {
    
    // MARK: - UI components
    
    let searchBar = SearchBar()
    
    let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(SearchTVCell.self, forCellReuseIdentifier: SearchTVCell.id)
        return tableView
    }()
    
    let emptyView = UIView()
    
    func setEmptyView(view: UIView) {
        emptyView.removeAllSubViews()
        emptyView.addSubview(view)
        view.setAutoLayout(to: emptyView)
    }
    
    func setHiddenForEmptyView(isHidden: Bool) {
        emptyView.isHidden = isHidden
        emptyView.frame.size.height = isHidden ? 0 : 300
    }
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    override func initSubviews() {
        addSubviews([
            searchBar,
            emptyView,
            searchTableView
        ])
    }
    
    override func initConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(searchTableView).offset(50)
            make.horizontalEdges.equalTo(searchTableView).inset(30)
            make.height.equalTo(300)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
