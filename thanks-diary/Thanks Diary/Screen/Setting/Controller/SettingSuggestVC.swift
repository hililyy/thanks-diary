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
    
    let settingSuggestView = SettingSuggestView()
    var viewModel: SettingViewModel?
    
    override func loadView() {
        view = settingSuggestView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        settingSuggestView.tableView.delegate = self
        settingSuggestView.tableView.dataSource = self
    }
    
    func setTarget() {
        settingSuggestView.backButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.popVC()
            })
            .disposed(by: disposeBag)
    }
}

extension SettingSuggestVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingSuggestView.tableView.dequeueReusableCell(withIdentifier: SettingLabelTVCell.id, for: indexPath) as! SettingLabelTVCell
        cell.titleLabel.text = "\(indexPath.row) 번"
        cell.contentsLabel.text = "완료"
        
        return cell
    }
}
