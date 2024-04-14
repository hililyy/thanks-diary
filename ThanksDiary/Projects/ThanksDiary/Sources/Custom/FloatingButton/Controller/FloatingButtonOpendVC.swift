//
//  FloatingButtonOpendVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

final class FloatingButtonOpendVC: BaseVC<FloatingButtonOpendView> {
    
    // MARK: - Life Cycle
    
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
            self.attachedView.setOpenConstraints()
            self.view.layoutIfNeeded()
        }
    }
    
    func updateCloseConstraints() {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            self.attachedView.setCloseConstraints()
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismissVC(isAnimated: false)
        }
    }
    
    private func setTarget() {
        attachedView.setDetailLabel(label: L10n.detail)
        attachedView.setSimpleLabel(label: L10n.simple)
        
        attachedView.backgroundButton.addTarget { _ in
            self.updateCloseConstraints()
        }
        
        attachedView.closeButton.button.addTarget { _ in
            self.updateCloseConstraints()
        }
    }
}
