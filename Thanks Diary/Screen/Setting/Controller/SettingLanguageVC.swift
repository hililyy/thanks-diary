//
//  SettingLanguageVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2024/01/18.
//

import UIKit

final class SettingLanguageVC: BaseVC<SettingView> {
    
//    let languageList = ["한국어", "영어"]
    var selectedLanguage: LanguageType = .korea
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
    }
}

extension SettingLanguageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LanguageType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = attachedView.tableView.dequeueReusableCell(withIdentifier: SettingCheckTVCell.id, for: indexPath) as? SettingCheckTVCell else { return UITableViewCell() }
        cell.titleLabel.text = LanguageType(rawValue: indexPath.row)?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguage = LanguageType(rawValue: indexPath.row) ?? .korea
        print(selectedLanguage)
    }
}

// MARK: - initalize

extension SettingLanguageVC {
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
        attachedView.setNavigationTitle(title: L10n.settingName15)
    }
}
