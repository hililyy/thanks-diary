//
//  FloatingButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

class FloatingButtonVC: BaseVC {
    
    let floatingButtonCloseView = FloatingButtonCloseView()
    
    public var detailHandler: () -> () = {}
    public var simpleHandler: () -> () = {}
    
    override func loadView() {
        view = floatingButtonCloseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setOpenConstraints()
    }
    
    func setOpenConstraints() {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            self.floatingButtonCloseView.setOpenConstraints()
            self.view.layoutIfNeeded()
        }
    }
    
    func setCloseConstraints() {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            self.floatingButtonCloseView.setCloseConstraints()
            self.view.layoutIfNeeded()
        } completion: { completion in
            self.dismiss(animated: false)
        }
    }
    
    private func setupViews() {
        floatingButtonCloseView.setDetailLabel(label: "자세하게")
        floatingButtonCloseView.setSimpleLabel(label: "간단하게")
        
        floatingButtonCloseView.backgroundButton.addTarget {
            self.dismiss(animated: true)
        }
        
        floatingButtonCloseView.plusButton.button.addTarget {
            self.dismiss(animated: true)
        }
        
        floatingButtonCloseView.detailButton.button.addTarget {
            self.dismiss(animated: true) {
                self.detailHandler()
            }
        }
        
        floatingButtonCloseView.simpleButton.button.addTarget {
            self.dismiss(animated: true) {
                self.simpleHandler()
            }
        }
    }
}
