//
//  BaseView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/18.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class BaseView: UIView {
    
    public var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setTarget()
        addSubView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {}
    func setTarget() {}
    func addSubView() {}
    func setConstraints() {}
}
