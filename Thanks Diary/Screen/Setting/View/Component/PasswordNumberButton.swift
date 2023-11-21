//
//  PasswordNumberButton.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/11/21.
//

import UIKit

final class PasswordNumberButton: UIButton {
    convenience init(number: Int) {
        self.init()
        tag = number
        initalize()
    }
    
    private func initalize() {
        frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        adjustsImageWhenHighlighted = false
        setImage(number: tag)
    }
    
    private func setImage(number: Int) {
        switch number {
        case 0:
            setImage(Asset.Image.icZero.image, for: .normal)
        case 1:
            setImage(Asset.Image.icOne.image, for: .normal)
        case 2:
            setImage(Asset.Image.icTwo.image, for: .normal)
        case 3:
            setImage(Asset.Image.icThree.image, for: .normal)
        case 4:
            setImage(Asset.Image.icFour.image, for: .normal)
        case 5:
            setImage(Asset.Image.icFive.image, for: .normal)
        case 6:
            setImage(Asset.Image.icSix.image, for: .normal)
        case 7:
            setImage(Asset.Image.icSeven.image, for: .normal)
        case 8:
            setImage(Asset.Image.icEight.image, for: .normal)
        case 9:
            setImage(Asset.Image.icNine.image, for: .normal)
        case -1:
            setImage(Asset.Image.icDelete.image, for: .normal)
        default:
            break
        }
    }
}
