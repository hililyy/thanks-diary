//
//  SettingVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit
import AcknowList
import RxSwift
import RxCocoa

final class SettingVC: BaseVC {
    
    // MARK: - Property
    
    private let settingView = SettingView()
    let viewModel = SettingViewModel()
    private var alarmFlag: Bool = false
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaultManager.string(forKey: UserDefaultKey.PASSWORD).isEmpty {
            UserDefaultManager.set(false, forKey: UserDefaultKey.IS_PASSWORD)
        }
        alarmFlag = UserDefaultManager.bool(forKey: UserDefaultKey.IS_PASSWORD)
        settingView.tableView.reloadData()
    }
    
    // MARK: - Function
    
    private func setTarget() {
        settingView.backButton.rx.tap
            .asDriver()
            .drive(onNext: {[weak self] in
                guard let self else { return }
                self.popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func setTable() {
        settingView.settingNames.bind(to: settingView.tableView.rx.items) { tableView, index, element in
            switch element.type {
            case ._switch:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingSwitchTVCell.id) as? SettingSwitchTVCell else { return UITableViewCell() }
                cell.titleLabel.text = element.title
                cell.settingSwitch.isOn = self.alarmFlag
                cell.switchTapHandler = {
                    self.alarmFlag.toggle()
                    UserDefaultManager.set(self.alarmFlag, forKey: UserDefaultKey.IS_PASSWORD)
                    if self.alarmFlag {
                        let vc = SettingPWVC()
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        UserDefaultManager.set("", forKey: UserDefaultKey.PASSWORD)
                    }
                }
                
                return cell
                
            case .more:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingMoreTVCell.id) as? SettingMoreTVCell else { return UITableViewCell() }
                cell.titleLabel.text = element.title
                return cell
                
            case .label:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingLabelTVCell.id) as? SettingLabelTVCell else { return UITableViewCell() }
                cell.titleLabel.text = element.title
                cell.contentsLabel.text = CommonUtilManager.shared.getAppVersion()
                return cell
                
            default:
                break
            }
            
            return UITableViewCell()
        }
        .disposed(by: disposeBag)
        
        Observable.zip(settingView.tableView.rx.modelSelected(SettingNameModel.self), settingView.tableView.rx.itemSelected)
            .bind { [weak self] diary, index in
                guard let self else { return }
                
                switch index.row {
                case 0: // 암호
                    break
                    
                case 1: // 알림
                    let vc = SettingAlarmVC()
                    vc.viewModel = viewModel
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 2: // 테마 설정
                    let vc = SettingThemeVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 3: // 건의하기
                    let vc = SettingSuggestVC()
                    vc.viewModel = viewModel
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                case 4: // 오픈소스 라이선스
                    let acknowList = AcknowListViewController(fileNamed: "Pods-Thanks Diary-acknowledgements")
                            navigationController?.pushViewController(acknowList, animated: true)
                          
                case 5: // 앱 버전
                    LocalNotificationManager.shared.printPendingNotification()
                    
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}
