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
        setTarget()
        setTable()
    }
    
    // MARK: - Function
    
    func setTarget() {
        settingSuggestView.backButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.popVC()
            })
            .disposed(by: disposeBag)
        
        settingSuggestView.writeButton.rx.tap
            .asDriver()
            .drive(onNext: {
                let vc = SettingSuggestWriteVC()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                vc.viewModel = self.viewModel
                self.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func setTable() {
        viewModel?.suggestData
            .bind(to: settingSuggestView.tableView.rx.items(
                cellIdentifier: SettingSuggestTVCell.id,
                cellType: SettingSuggestTVCell.self)) { index, item, cell in
                    cell.contentsLabel.text = item.contents
                    cell.statusLabel.text = SuggestType(rawValue: item.status ?? "")?.description
                    cell.setStatusLabelUI(SuggestType(rawValue: item.status ?? "") ?? .waiting)
                    self.settingSuggestView.loading.stopAnimating()
                }
                .disposed(by: disposeBag)
    }
}
