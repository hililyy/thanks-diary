//
//  UIControl.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/18.
//

import UIKit

extension UIControl {
    func addTarget(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}
