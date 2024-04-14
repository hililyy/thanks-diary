//
//  UILabel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/16.
//

import UIKit

extension UILabel {
    func initLabelUI(text: String = "", 
                     color: UIColor,
                     font: UIFont) {
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
        guard let text = text,
              !text.isEmpty else { return }
        
        let kernValue = self.font.pointSize * CGFloat(spacing)
        let string = NSMutableAttributedString(string: text)
        
        string.addAttribute(NSAttributedString.Key.kern,
                            value: kernValue,
                            range: NSRange(location: 0,
                                           length: string.length - 1))
        attributedText = string
    }
    
    // TODO: 추후 리팩토링 필요 (코드.. 넘나... 지저분...)
    func setHighlightText(basicText: String,
                          basicTextColor: UIColor,
                          highlightText: String,
                          highlightTextColor: UIColor,
                          font: UIFont) {
        
        var basicString = NSMutableAttributedString(string: basicText)
        
        basicString = basicString.applyStylesToRange(text: basicText,
                                           font: font,
                                           color: basicTextColor)
        
        let highlightRange = searchCorrectTextsFirstRange(text: basicText, target: highlightText)
        basicString = basicString.applyStylesToRange(text: highlightText,
                                                     font: font,
                                                     color: highlightTextColor,
                                                     range: highlightRange)
        
        let highlightLocation = highlightRange?.location ?? 0
        let highlightLength = highlightRange?.length ?? 0
        
        let maxLength = 30 // 표기가능 최대 길이
//        let totalLength = maxLength - highlightLength
        let halfTotalLength = (maxLength - highlightLength) / 2
        
        let basicCount = basicText.count
        var combinedString = NSMutableAttributedString()
        
        if basicCount <= maxLength {
            attributedText = basicString
            return
        }
        
        if highlightLocation <= halfTotalLength {
            // 제일 앞부터 텍스트 자름
            var newRange = NSRange(location: 0, length: maxLength)
            
            // 혹시 out of Range 될까봐 써둠
            newRange.location = min(basicCount - 1, newRange.location)
            newRange.length = min(basicCount - newRange.location + 1, newRange.length)
            
            let subAttributedString = basicString.attributedSubstring(from: newRange)
            
            combinedString.append(subAttributedString)
            combinedString.append(NSMutableAttributedString(string: " ..."))
            
        } else if basicCount - highlightLocation < maxLength {
            // 제일 뒤까지 텍스트 자름
            let startRange =  basicCount - ((halfTotalLength * 2) + highlightLength)
            var newRange = NSRange(location: startRange, length: basicCount - startRange)
            
            // 혹시 out of Range 될까봐 써둠
            newRange.location = min(basicCount - 1, newRange.location)
            newRange.length = min(basicCount - newRange.location + 1, newRange.length)
            
            let subAttributedString = basicString.attributedSubstring(from: newRange)
            
            combinedString.append(NSMutableAttributedString(string: "···"))
            combinedString.append(subAttributedString)
            
        } else if highlightLocation > halfTotalLength && basicCount - maxLength > highlightLocation {
            // 중간에서 텍스트 자름
            var newRange = NSRange(location: highlightLocation - halfTotalLength, length: maxLength)

            // 혹시 out of Range 될까봐 써둠
            newRange.location = min(basicCount - 1, newRange.location)
            newRange.length = min(basicCount - newRange.location + 1, newRange.length)
            
            let subAttributedString = basicString.attributedSubstring(from: newRange)
            combinedString.append(NSMutableAttributedString(string: "···"))
            combinedString.append(subAttributedString)
            combinedString.append(NSMutableAttributedString(string: " ..."))
            
        } else {
            
            combinedString = basicString
        }
        
        attributedText = combinedString
    }
    
    private func searchCorrectTextsFirstRange(text: String, target: String) -> NSRange? {
        let attrStr = NSMutableAttributedString(string: text).string as NSString
        var range = NSRange(location: 0, length: text.count)
        
        while range.location != NSNotFound {
            range = attrStr.range(of: target,
                                  options: .caseInsensitive,
                                  range: range)
            if range.location != NSNotFound { return range }
        }
        
        return nil
    }
}

extension NSMutableAttributedString {
    func applyStylesToRange(text: String,
                            font: UIFont,
                            color: UIColor,
                            range: NSRange? = nil) -> NSMutableAttributedString {
        
        let newRange = range ?? (self.string as NSString).range(of: text)
        
        addAttribute(.foregroundColor,
                     value: color,
                     range: newRange)
        addAttribute(.font,
                     value: font,
                     range: newRange)
        return self
    }
}
