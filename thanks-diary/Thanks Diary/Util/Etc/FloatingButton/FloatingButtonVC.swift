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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setOpenConstraints()
    }
    
    func setOpenConstraints() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.floatingButtonCloseView.setOpenConstraints()
            self.view.layoutIfNeeded() // 화면 갱신
        }
    }
    
    func setCloseConstraints() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.floatingButtonCloseView.setCloseConstraints()
            self.view.layoutIfNeeded() // 화면 갱신
        } completion: { completion in
            // 애니메이션이 끝나는 시점
            self.dismiss(animated: false)
        }
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
