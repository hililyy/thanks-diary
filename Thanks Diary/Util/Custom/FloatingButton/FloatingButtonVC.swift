//
//  FloatingButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

final class FloatingButtonVC: BaseVC {
    
    // MARK: - Property
    
    let floatingButtonCloseView = FloatingButtonCloseView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = floatingButtonCloseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateOpenConstraints()
    }
    
    // MARK: - Function
    
    func updateOpenConstraints() {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            self.floatingButtonCloseView.setOpenConstraints()
            self.view.layoutIfNeeded()
        }
    }
    
    func updateCloseConstraints() {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            self.floatingButtonCloseView.setCloseConstraints()
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismissVC(isAnimated: false)
        }
    }
    
    private func setTarget() {
        floatingButtonCloseView.setDetailLabel(label: L10n.detail)
        floatingButtonCloseView.setSimpleLabel(label: L10n.simple)
        
        floatingButtonCloseView.backgroundButton.addTarget { _ in
            self.updateCloseConstraints()
        }
        
        floatingButtonCloseView.plusButton.button.addTarget { _ in
            self.updateCloseConstraints()
        }
    }
}
