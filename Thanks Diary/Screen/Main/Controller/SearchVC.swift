//
//  SearchVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/12/05.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchVC: BaseVC<SearchView> {
    
    // MARK: - Property
    
    var viewModel: MainViewModel?
    private var searchResultData = PublishSubject<[DiarySearchModel]>()
    private var inputText = ""
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.readData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        attachedView.searchBar.textfield.becomeFirstResponder()
    }
    
    private func search(inputText: String) {
        var resultData: [DiarySearchModel] = []
        
        let detailData = viewModel?.allDetailDataRx.value ?? [:]
        let simpleData = viewModel?.allSimpleDataRx.value ?? [:]
        var allData = detailData
        
        for key in simpleData.keys {
            
            if allData[key] == nil {
                allData[key] = []
            }
            
            let m = simpleData[key] ?? []
            allData[key]?.append(contentsOf: m)
        }
        
        for data in allData.values {
            for model in data {
                let title = model.title
                let contents = model.contents
                var searchModel = DiarySearchModel(type: model.type,
                                                   title: model.title,
                                                   contents: model.contents,
                                                   date: model.date,
                                                   correctType: .title)
                if title.contains(inputText) {
                    searchModel.correctType = .title
                    resultData.append(searchModel)
                    
                } else if contents.contains(inputText) {
                    searchModel.correctType = .contents
                    resultData.append(searchModel)
                }
            }
        }
        
        searchResultData.onNext(resultData)
    }
    
    private func pushDetailWriteVC(beforeData: DiaryModel?) {
        let vc = DetailWriteVC()
        vc.viewModel = viewModel
        vc.beforeData = beforeData
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentSimpleWriteVC(beforeData: DiaryModel?) {
        let vc = SimpleWriteVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.viewModel = viewModel
        vc.beforeData = beforeData
        present(vc, animated: true)
    }
    
    private func initTable() {
        attachedView.searchTableView.delegate = nil
        attachedView.searchTableView.dataSource = nil
        
        settingTableViewEmptyImageOrData()
        initTableViewCellForRow()
        initTableViewDidSelected()
    }
    
    private func settingTableViewEmptyImageOrData() {
        searchResultData
            .subscribe(onNext: { [weak self] resultData in
                guard let self else { return }
                
                let notView = NotBeforeView()
                notView.contentsLabel.text = L10n.searchNotResult
                
                if resultData.isEmpty && !inputText.isEmpty {
                    attachedView.setHiddenForEmptyView(isHidden: false)
                    attachedView.setEmptyView(view: notView)
                } else {
                    attachedView.setHiddenForEmptyView(isHidden: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func initTableViewCellForRow() {
        searchResultData
            .bind(to: attachedView.searchTableView.rx.items(cellIdentifier: SearchTVCell.id,
                                                            cellType: SearchTVCell.self)) { [weak self] _, element, cell in
                
                let contentsLabelText = element.correctType == .title ? element.title : element.contents
                let searchText = self?.attachedView.searchBar.textfield.text ?? ""
                cell.setContentsLabelStyle(searchText: searchText,
                                           contentsLabelText: contentsLabelText)
                cell.dateLabel.text = element.date
            }
            .disposed(by: disposeBag)
    }
    
    private func initTableViewDidSelected() {
        attachedView.searchTableView.rx.modelSelected(DiarySearchModel.self)
            .subscribe(onNext: {[weak self] model in
                guard let self else { return }
                
                attachedView.searchBar.textfield.resignFirstResponder()
                
                let diaryModel = DiaryModel(type: model.type,
                                            title: model.title,
                                            contents: model.contents,
                                            date: model.date)
                
                viewModel?.selectedDate.accept(model.date.convertDate() ?? Date())
                
                if diaryModel.type == .detail {
                    self.pushDetailWriteVC(beforeData: diaryModel)
                } else {
                    self.presentSimpleWriteVC(beforeData: diaryModel)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension SearchVC {
    private func initalize() {
        initTarget()
        initTable()
        initObservable()
    }
    
    private func initTarget() {
        initBackButtonTarget()
        initTextFieldTarget()
    }
    
    private func initBackButtonTarget() {
        attachedView.searchBar.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initTextFieldTarget() {
        attachedView.searchBar.textfield.rx.text
             .orEmpty
             .debounce(.seconds(1), scheduler: MainScheduler.instance)
             .subscribe(onNext: { [weak self] searchText in
                 guard let self else { return }
                 
                 inputText = searchText
                 search(inputText: searchText)
             })
             .disposed(by: disposeBag)
    }
    
    private func initObservable() {
        viewModel?.allSimpleDataRx.subscribe(onNext: { _ in
            self.search(inputText: self.inputText)
        })
        .disposed(by: disposeBag)
    }
}
