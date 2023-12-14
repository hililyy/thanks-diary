//
//  SettingAlarmMessageVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/12/13.
//

import UIKit

final class SettingAlarmMessageVC: BaseVC<SettingAlarmMessageView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - initalize

extension SettingAlarmMessageVC {
    private func initalize() {
        initUI()
        initTarget()
    }
    
    private func initUI() {
        var title = UserDefaultManager.instance.pushMessageTitle
        var contents = UserDefaultManager.instance.pushMessageContents
        
        if title.isEmpty || contents.isEmpty {
            UserDefaultManager.instance.pushMessageTitle = L10n.pushTitleGeneral
            UserDefaultManager.instance.pushMessageContents = L10n.pushContentsGeneral
            title = L10n.pushTitleGeneral
            contents = L10n.pushContentsGeneral
        }
        
        attachedView.messageTitleTextField.text = title
        attachedView.messageContentsTextField.text = contents
        attachedView.previewTitleLabel.text = title
        attachedView.previewContentsLabel.text = contents
    }
    
    private func initTarget() {
        attachedView.navigationView.backButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.popVC()
            })
            .disposed(by: disposeBag)
        
        attachedView.completeButton.rx.tap
            .asDriver()
            .drive(onNext: {
                var title = self.attachedView.messageTitleTextField.text ?? ""
                var contents = self.attachedView.messageContentsTextField.text ?? ""
                
                if title.isEmpty {
                    title = L10n.pushTitleGeneral
                }
                
                if contents.isEmpty {
                    contents = L10n.pushContentsGeneral
                }
                
                UserDefaultManager.instance.pushMessageTitle = title
                UserDefaultManager.instance.pushMessageContents = contents
                LocalNotificationManager.instance.removeDeliveredNotification()
                let time = UserDefaultManager.instance.pushTime
                LocalNotificationManager.instance.registNotification(time: time)
                
                self.popVC()
            })
            .disposed(by: disposeBag)
    }
}
