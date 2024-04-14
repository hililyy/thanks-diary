//
//  UIButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/16.
//

import UIKit

extension UIButton {
    func initButtonUI(text: String, font: UIFont, color: UIColor) {
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(color, for: .normal)
    }
}
