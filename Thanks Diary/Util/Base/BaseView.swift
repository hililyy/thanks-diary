//
//  BaseView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BaseView: UIView {
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initTarget()
        initSubviews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {}
    func initTarget() {}
    func initSubviews() {}
    func initConstraints() {}
}
