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
    var selectedIndex: Int?
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
        readView.setTopLabelData(date: viewModel?.selectedDate)
        
        guard let index = selectedIndex,
              let titleText = viewModel?.selectedDetailData[index].title,
              let contentsText = viewModel?.selectedDetailData[index].contents else { return }
        
        readView.setTextFieldData(titleText: titleText,
                                  contentsText: contentsText)
    }
    
    private func setTarget() {
        readView.backButtonTapHandler = {
            self.popVC()
        }
        
        readView.deleteButtonTapHandler = {
            guard let selectedIndex = self.selectedIndex else { return }
            
            let vc = AlertVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.rightButtonTapHandler = {
                self.viewModel?.deleteDetailData(selectedIndex: selectedIndex) { result in
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
            vc.updateFlag = true
            vc.selectedIndex = self.selectedIndex
            vc.viewModel = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
