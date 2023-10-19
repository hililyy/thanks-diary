//
//  UILabel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/16.
//

import UIKit

extension UILabel {
    func initLabelUI(text: String = "", color: UIColor, font: UIFont) {
        self.text = text
        self.textColor = color
        self.font = font
    }
    
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    func setCharacterSpacing(spacing: Double = -0.025) {
        let kernValue = self.font.pointSize * CGFloat(spacing)
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
}
