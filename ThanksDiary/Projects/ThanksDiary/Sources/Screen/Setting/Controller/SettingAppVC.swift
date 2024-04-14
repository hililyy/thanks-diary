//
//  SettingAppVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/20.
//

import UIKit
import AcknowList

final class SettingAppVC: BaseVC<SettingView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
    }
}

extension SettingAppVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = attachedView.tableView.dequeueReusableCell(withIdentifier: SettingLabelTVCell.id, for: indexPath) as? SettingLabelTVCell else { return UITableViewCell() }
            cell.titleLabel.text = L10n.settingName6
            cell.contentsLabel.text = CommonUtilManager.instance.appVersion
            return cell

        case 1, 2:
            guard let cell = attachedView.tableView.dequeueReusableCell(withIdentifier: SettingMoreTVCell.id, for: indexPath) as? SettingMoreTVCell else { return UITableViewCell() }
            cell.titleLabel.text = indexPath.row == 1 ? L10n.settingName10 : L10n.settingName5
            return cell

        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            printRegistedNotification()
            
        case 1:
            moveAppEvaluation()
            
        case 2:
            pushOpenSourceLicenseVC()
            
        default:
            break
        }
    }
}

// MARK: - initalize

extension SettingAppVC {
    private func initalize() {
        initTarget()
        initDelegate()
        initNavigationTitle()
    }
    
    private func initTarget() {
        initBackButtonTarget()
    }
    
    private func initBackButtonTarget() {
        attachedView.navigationView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initDelegate() {
        attachedView.tableView.dataSource = self
        attachedView.tableView.delegate = self
    }
    
    private func initNavigationTitle() {
        attachedView.setNavigationTitle(title: L10n.settingName11)
    }
}

// MARK: - View Change

extension SettingAppVC {
    private func printRegistedNotification() {
        LocalNotificationManager.instance.printRegistedNotification()
    }
    
    private func moveAppEvaluation() {
        CommonUtilManager.instance.moveAppStoreReview()
    }
    
    private func pushOpenSourceLicenseVC() {
        let acknowList = AcknowListViewController(fileNamed: "Package")
        acknowList.modalTransitionStyle = .coverVertical
        acknowList.modalPresentationStyle = .popover
        present(acknowList, animated: true)
    }
}
