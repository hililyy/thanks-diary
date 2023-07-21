//
//  ReadVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/22.
//

import UIKit

final class ReadVC: BaseVC {
    
    private let readView = ReadView()
    var selectedIndex: Int?
    var parentVC: MainVC?
    
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
    
    private func configureUI() {
        readView.setTopLabelData(date: parentVC?.viewModel.selectedDate)
        
        guard let index = selectedIndex,
              let titleText = parentVC?.viewModel.selectedDetailData[index].title,
              let contentsText = parentVC?.viewModel.selectedDetailData[index].contents else { return }
        
        readView.setTextFieldData(titleText: titleText,
                                  contentsText: contentsText)
    }
    
    private func setTarget() {
        readView.backButton.addTarget {
            self.popVC()
        }
        
        readView.deleteButton.addTarget {
            guard let selectedIndex = self.selectedIndex else { return }
            
            let vc = AlertVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.deleteButtonTapHandler = {
                self.parentVC?.viewModel.deleteDetailData(selectedIndex: selectedIndex) { result in
                    if result {
                        self.setMainToRoot()
                    } else {
                        self.dismissVC() {
                            self.presentErrorPopup()
                        }
                    }
                }
            }
            
            self.present(vc, animated: true)
        }
        
        readView.updateButton.addTarget {
            let vc = DetailWriteVC()
            vc.updateFlag = true
            vc.selectedIndex = self.selectedIndex
            vc.parentVC = self.parentVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
