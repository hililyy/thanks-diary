//
//  ReadVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/22.
//

import UIKit

final class ReadVC: BaseVC {
    
    // MARK: - Property
    
    private let readView = ReadView()
    var diaryData: DiaryModel?
    var viewModel: MainViewModel?
    
    // MARK:- Life Cycle
    
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
        
        guard let titleText = diaryData?.title,
              let contentsText = diaryData?.contents else { return }
        
        readView.setTextFieldData(titleText: titleText,
                                  contentsText: contentsText)
    }
    
    private func setTarget() {
        guard let diaryData = diaryData else { return }
        
        readView.backButtonTapHandler = {
            self.popVC()
        }
        
        readView.deleteButtonTapHandler = {
            let vc = AlertVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.rightButtonTapHandler = {
                self.viewModel?.deleteData(deleteData: diaryData) { result in
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
        
        readView.updateButtonTapHandler = {
            let vc = DetailWriteVC()
            vc.viewModel = self.viewModel
            vc.beforeData = diaryData
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
