//
//  UIScrollView+.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/08.
//

import UIKit

extension UIScrollView {
    
    // 최상단으로 이동
    func scrollToTop() {
        setContentOffset(.zero, animated: true)
    }
    
    // 특정 위치로 이동
    func scrollToCenter(height: CGFloat) {
        let centerOffset = CGPoint(x: 0, y: (contentSize.height - bounds.size.height + height) )
        setContentOffset(centerOffset, animated: true)
    }

    // 최하단으로 이동
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
