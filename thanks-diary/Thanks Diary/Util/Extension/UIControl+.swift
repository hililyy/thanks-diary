//
//  UIControl.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/18.
//

import UIKit

extension UIControl {
    
    func addTarget(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping (UIControl) -> Void) {
        addAction(UIAction { (action: UIAction) in
            guard let sender = action.sender as? UIControl else { return }
            closure(sender)
        }, for: controlEvents)
    }
}
