//
//  ReadVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/22.
//

import UIKit
import RxSwift
import RxCocoa

final class ReadVC: BaseVC {
    
    // MARK: - Property
    
    private let readView = ReadView()
    var viewModel: MainViewModel?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = readView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Function
    
    private func configureUI() {
        readView.setTopLabelData(date: viewModel?.selectedDate.value)
        
        guard let diaryData = viewModel?.selectedDiaryData,
              let titleText = diaryData.title,
              let contentsText = diaryData.contents else { return }
        
        readView.setTextFieldData(titleText: titleText,
                                  contentsText: contentsText)
    }
    
    private func setTarget() {
        readView.backButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.popVC()
            })
            .disposed(by: disposeBag)
        
        readView.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.presentAlertVC()
            })
            .disposed(by: disposeBag)
        
        readView.updateButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.pushDetailWriteVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func presentAlertVC() {
        let vc = AlertVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.rightButtonTapHandler = {
            self.viewModel?.deleteData() { result in
                if result {
                    self.setMainToRoot()
                } else {
                    self.dismissVC() {
                        self.showErrorPopup()
                    }
                }
            }
        }
        self.present(vc, animated: true)
    }
    
    private func pushDetailWriteVC() {
        let vc = DetailWriteVC()
        vc.viewModel = self.viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
