//
//  UIScrollView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/08.
//

import UIKit

extension UIScrollView {
    
    func scrollToTop() {
        setContentOffset(.zero, animated: true)
    }
    
    func scrollTo(positionY: CGFloat) {
        let centerOffset = CGPoint(x: 0, y: (contentSize.height - bounds.size.height + positionY) )
        setContentOffset(centerOffset, animated: true)
    }

    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if bottomOffset.y > 0 {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
