//
//  UIView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit

extension UIView {
    
    func setAutoLayout(to: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: to.topAnchor),
            self.leadingAnchor.constraint(equalTo: to.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: to.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: to.bottomAnchor)
        ])
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
