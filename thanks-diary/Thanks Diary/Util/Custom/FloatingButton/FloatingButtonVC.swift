//
//  FloatingButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

final class FloatingButtonVC: BaseVC {
    
    let floatingButtonCloseView = FloatingButtonCloseView()
    
    public var detailHandler: () -> () = {}
    public var simpleHandler: () -> () = {}
    
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
        } completion: { completion in
            self.dismissVC(isAnimated: false)
        }
    }
    
    private func setTarget() {
        floatingButtonCloseView.setDetailLabel(label: "text_detail".localized)
        floatingButtonCloseView.setSimpleLabel(label: "text_simple".localized)
        
        floatingButtonCloseView.backgroundButton.addTarget {
            self.updateCloseConstraints()
        }
        
        floatingButtonCloseView.plusButton.button.addTarget {
            self.updateCloseConstraints()
        }
        
        floatingButtonCloseView.detailButton.button.addTarget {
            self.dismissVC() {
                self.detailHandler()
            }
        }
        
        floatingButtonCloseView.simpleButton.button.addTarget {
            self.dismissVC() {
                self.simpleHandler()
            }
        }
    }
}
