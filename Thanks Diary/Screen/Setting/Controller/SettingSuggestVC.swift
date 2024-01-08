//
//  SettingSuggestVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/09/05.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingSuggestVC: BaseVC<SettingSuggestView> {
    
    // MARK: - Property
    
    var viewModel: SettingViewModel
    
    // MARK: - Init
    
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
        viewModel.getSuggestDatas()
    }
}

// MARK: - initalize

extension SettingSuggestVC {
    private func initalize() {
        initTarget()
        initTable()
    }
    
    private func initTarget() {
        initBackButtonTarget()
        initWriteButtonTarget()
    }
    
    private func initBackButtonTarget() {
        attachedView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initWriteButtonTarget() {
        attachedView.writeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                presentSettingSuggestWriteVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initTable() {
        viewModel.suggestData
            .bind(to: attachedView.tableView.rx.items) { [weak self] tableView, index, item in
                guard let self else { return UITableViewCell() }
                
                if item.status != "reply" {
                    guard let suggestCell = tableView.dequeueReusableCell(withIdentifier: SettingSuggestTVCell.id) as? SettingSuggestTVCell else { return UITableViewCell() }
                    suggestCell.contentsLabel.text = item.contents
                    suggestCell.statusLabel.text = SuggestType(rawValue: item.status)?.description
                    suggestCell.setStatusLabelUI(SuggestType(rawValue: item.status) ?? .waiting)
                    suggestCell.createDateLabel.text = item.createDate
                    suggestCell.likeLabel.text = "\(item.likeCount)"
                    
                    attachedView.loading.stopAnimating()
                    
                    return suggestCell
                } else {
                    guard let replyCell = tableView.dequeueReusableCell(withIdentifier: SettingSuggestReplyTVCell.id) as? SettingSuggestReplyTVCell else { return UITableViewCell() }
                    replyCell.contentsLabel.text = item.contents
                    replyCell.createDateLabel.text = item.createDate
                    
                    attachedView.loading.stopAnimating()
                    
                    return replyCell
                }
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - View Change

extension SettingSuggestVC {
    private func presentSettingSuggestWriteVC() {
        let vc = SettingSuggestWriteVC(viewModel: self.viewModel)
        vc.viewModel = viewModel
        present(vc, animated: true)
    }
}
