//
//  UIStackView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/16.
//

import UIKit

extension UIStackView {
    func initStackViewUI(spacing: CGFloat,
                         axis: NSLayoutConstraint.Axis,
                         distribution: UIStackView.Distribution = .fill,
                         alignment: UIStackView.Alignment = .fill) {
        self.spacing = spacing
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
