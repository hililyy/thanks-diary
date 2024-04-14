//
//  AnimationManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2024/01/15.
//

import UIKit

struct AnimationManager {
    static func animationFadeIn(view: UIView) {
        view.alpha = 0
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.03,
            animations: {
                view.alpha = 1
            })
    }
    
    static func animationPop(view: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0.0, animations: {
            view.transform = CGAffineTransform(scaleX: 1.015, y: 1.015)
        }, completion: { _ in
            UIView.animate(withDuration: 0.15, animations: {
                view.transform = CGAffineTransform.identity
            })
        })
    }
    
    static func animationCurveEaseInOut(completion: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            options: [.curveEaseInOut],
            animations: {
                completion()
        })
    }
    
    static func animationMoveUpWithFadeIn(cell: UITableViewCell, indexPath: Int) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height * 0.3)
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0.03 * Double(indexPath),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
        })
    }
    
    static func animationShake(view: UIView) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = 0.4
        animation.isAdditive = true
        
        view.layer.add(animation, forKey: "shake")
    }
}
