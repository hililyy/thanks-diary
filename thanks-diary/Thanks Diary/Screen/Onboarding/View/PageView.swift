//
//  PageView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/07.
//

import UIKit
import Then
import SnapKit

class PageView: UIView {
    
    lazy var containerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var progressStackView =  UIStackView(arrangedSubviews: [firstDotView, secondDotView, thirdDotView]).then {
        $0.spacing = 8
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    var firstDotView = UIView().then {
        $0.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
    }
    
    var secondDotView = UIView().then {
        $0.backgroundColor = Color.COLOR_GRAY3
    }
    
    var thirdDotView = UIView().then {
        $0.backgroundColor = Color.COLOR_GRAY3
    }
    
    var nextButton = UIButton(type: .custom).then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = Color.COLOR_GRAYBLUE
        $0.titleLabel?.font = Font.NANUM_LIGHT_18
        $0.setTitle("다음", for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addSubView()
        setDot()
        setConstraints()
    }
    
    func setDot() {
        firstDotView.layer.cornerRadius = 6
        secondDotView.layer.cornerRadius = 6
        thirdDotView.layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
    }
    
    private func addSubView() {
        addSubview(containerView)
        addSubview(progressStackView)
        addSubview(nextButton)
    }
    
    private func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(progressStackView.snp.bottom)
            make.left.equalTo(snp.left)
            make.bottom.equalTo(nextButton.snp.top)
            make.right.equalTo(snp.right)
            make.width.equalTo(snp.width)
        }
        
        progressStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(snp.centerX)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(30)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(54)
        }
        
        firstDotView.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        
        secondDotView.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        
        thirdDotView.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
    }
}
