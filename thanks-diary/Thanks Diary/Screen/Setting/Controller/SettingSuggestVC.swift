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
        setTarget()
        
        settingSuggestView.tableView.delegate = self
        settingSuggestView.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getSuggestDatas {
            self.settingSuggestView.tableView.reloadData()
            self.settingSuggestView.loading.stopAnimating()
        }
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
}

// MARK: - TableView

extension SettingSuggestVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.suggestData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingSuggestView.tableView.dequeueReusableCell(withIdentifier: SettingLabelTVCell.id, for: indexPath) as! SettingLabelTVCell
        cell.titleLabel.text = viewModel?.suggestData[indexPath.row].contents
        cell.contentsLabel.text = "완료"
        
        return cell
    }
}
