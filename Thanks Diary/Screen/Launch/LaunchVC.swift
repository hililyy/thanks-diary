//
//  LaunchVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/11.
//

import UIKit
import SnapKit

final class LaunchVC: UIViewController {
    
    // MARK: - Property
    
    var lottieView = UIView()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font =  ResourceManager.instance.getFont(size: 20)
        label.text = L10n.todayWell
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font =  ResourceManager.instance.getFont(size: 40)
        label.text = L10n.thanksDiary
        return label
    }()
    
    private var titleContentsView = UIView()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initUI()
        initLottie()
        initPasswordIfEmpty()
        initLaunch()
    }
    
    func initView() {
        view.addSubviews([
            lottieView,
            titleContentsView
        ])
        
        titleContentsView.addSubviews([
            subTitleLabel,
            titleLabel
        ])
        
        lottieView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(view.snp.width)
            make.center.equalToSuperview()
        }
        
        titleContentsView.snp.makeConstraints { make in
            make.centerX.equalTo(lottieView)
            make.centerY.equalTo(lottieView).offset(-40)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Function
    // TODO: 모드에 따른 컬러 미 적용으로 하드코딩 -> 추후 해결책 찾아서 제거
    private func initUI() {
        if UserDefaultManager.instance.themeMode == ThemeMode.dark.rawValue {
            view.backgroundColor = Asset.Color.customBlack.color
            subTitleLabel.textColor = .white
            titleLabel.textColor = .white
        } else {
            view.backgroundColor = .white
            subTitleLabel.textColor = Asset.Color.customBlack.color
            titleLabel.textColor = Asset.Color.customBlack.color
        }
    }
    
    private func initLottie() {
        let goLottie = LottieManager.LottieInfo(vc: self,
                                 lottieView: lottieView,
                                 name: Files.dotJson.name,
                                 speed: 3,
                                 mode: .loop)
        
        LottieManager.setLottie(goLottie)
    }
    
    // 비밀번호 ""으로 설정된 유저 비밀번호 변경(초기화 / 이전버전 앱 오류 해결방안)
    private func initPasswordIfEmpty() {
        let password = UserDefaultManager.instance.password
        
        if password.isEmpty {
            UserDefaultManager.instance.password = Constant.INIT_PASSWORD
        }
    }
    
    private func initLaunch() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            let isReEntry = UserDefaultManager.instance.isReEntryUser
            let isPassword = UserDefaultManager.instance.isPassword
            let isBioAuth = UserDefaultManager.instance.isBiometricsAuth
            
            if !isReEntry {
                self.registPageToRoot()
                return
            }
            
            if !isPassword && !isBioAuth {
                self.registMainToRoot()
                return
            }
            
            if !isBioAuth {
                self.presentSettingPWVC()
                return
            }
            
            self.bioAuth()
        }
    }
    
    private func bioAuth() {
        AuthManager.instance.executeBioAuth { [weak self] result in
            guard let self else { return }
            
            if result {
                registMainToRoot()
                return
            } else {
                showAlert()
            }
        }
    }
    
    private func showAlert() {
        let vc = AlertVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.attachedView.setText(message: L10n.alertBioauth,
                                leftButtonText: L10n.no,
                                rightButtonText: L10n.retry)
        vc.rightButtonTapHandler = {
            self.bioAuth()
        }
        
        present(vc, animated: true)
    }
    
    private func presentSettingPWVC() {
        let vc = SettingPWVC()
        vc.homeFlag = true
        vc.modalPresentationStyle = .currentContext
        self.present(vc, animated: true)
    }
    
    private func showErrorPopup() {
        DispatchQueue.main.async {
            let vc = AlertConfirmVC()
            vc.attachedView.setText(message: L10n.error,
                                    okButtonText: L10n.exit)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.okButtonTapHandler = {
                self.exitApp()
            }
            self.present(vc, animated: true)
        }
    }
    
    private func exitApp() {
        DispatchQueue.main.async {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(0)
            }
        }
    }
}
