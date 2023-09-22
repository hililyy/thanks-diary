//
//  PageView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/07.
//

import UIKit

final class PageView: BaseView {
    
    // MARK: - UI components
    
    lazy var containerView = UIView()
    
    private lazy var progressStackView = UIStackView(arrangedSubviews: [firstDotView, secondDotView, thirdDotView]).then { stackView in
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    var firstDotView = UIView().then { view in
        view.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        view.layer.cornerRadius = 6
    }
    
    var secondDotView = UIView().then { view in
        view.backgroundColor = Color.COLOR_GRAY3
        view.layer.cornerRadius = 6
    }
    
    var thirdDotView = UIView().then { view in
        view.backgroundColor = Color.COLOR_GRAY3
        view.layer.cornerRadius = 6
    }
    
    var nextButton = UIButton(type: .custom).then { button in
        button.layer.cornerRadius = 20
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.titleLabel?.font = Font.NANUM_LIGHT_18
        button.setTitle("text_next".localized, for: .normal)
        button.setTitleColor(Color.COLOR_GRAY6, for: .normal)
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = Color.COLOR_WHITE
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([containerView,
                     progressStackView,
                     nextButton])
    }

    override func initConstraints() {
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
