//
//  SettingSuggestVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingSuggestVC: BaseVC {
    
    // MARK: - Property
    
    let settingSuggestView = SettingSuggestView()
    var viewModel: SettingViewModel?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingSuggestView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getSuggestDatas()
        initTarget()
        initTable()
    }
    
    // MARK: - Function
    
    private func initTarget() {
        settingSuggestView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                popVC()
            })
            .disposed(by: disposeBag)
        
        settingSuggestView.writeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                let vc = SettingSuggestWriteVC()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                vc.viewModel = viewModel
                present(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func initTable() {
        viewModel?.suggestData
            .bind(to: settingSuggestView.tableView.rx.items(
                cellIdentifier: SettingSuggestTVCell.id,
                cellType: SettingSuggestTVCell.self)) {  [weak self] _, item, cell in
                    guard let self else { return }
                    cell.contentsLabel.text = item.contents
                    cell.statusLabel.text = SuggestType(rawValue: item.status ?? "")?.description
                    cell.setStatusLabelUI(SuggestType(rawValue: item.status ?? "") ?? .waiting)
                    settingSuggestView.loading.stopAnimating()
                }
                .disposed(by: disposeBag)
    }
}
