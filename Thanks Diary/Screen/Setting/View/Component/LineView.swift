//
//  LineView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/18.
//

import UIKit

final class LineView: BaseView {
    
    // MARK: - UI components
    
    private let lineView = UIView()
    
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
            make.edges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
