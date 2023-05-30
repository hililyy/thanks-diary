//
//  FloatingButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

class FloatingButtonVC: BaseVC {
    
    private let floatingButtonCloseView = FloatingButtonCloseView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(floatingButtonCloseView)
        
        floatingButtonCloseView.setDetailLabel(label: "자세하게")
        floatingButtonCloseView.setSimpleLabel(label: "간단하게")
        
        floatingButtonCloseView.backgroundButton.addTarget { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        floatingButtonCloseView.plusButton.button.addTarget { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        floatingButtonCloseView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            floatingButtonCloseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            floatingButtonCloseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            floatingButtonCloseView.topAnchor.constraint(equalTo: view.topAnchor),
            floatingButtonCloseView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            floatingButtonCloseView.plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
}
