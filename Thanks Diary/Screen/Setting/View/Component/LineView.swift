//
//  LineView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/18.
//

import UIKit

final class LineView: BaseView {
    
    // MARK: - UI components
    
    let lineView = UIView()
    
    // MARK: - UI, Target
    
    convenience init(color: UIColor) {
        self.init()
        self.lineView.backgroundColor = color
    }
    
    override func initSubviews() {
        addSubview(lineView)
    }
    
    override func initConstraints() {
        lineView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
            make.height.equalTo(1)
        }
    }
}
