//
//  UIView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit

extension UIView {
    public func setAutoLayout(to:UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: to, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: to, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: to, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: to, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        to.layoutIfNeeded()
    }
}
