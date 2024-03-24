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
    
    private let progressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    let firstDotView: UIView = {
       let view = UIView()
        view.backgroundColor = ResourceManager.instance.getMainColor()
        view.layer.cornerRadius = 6
        return view
    }()
    
    let secondDotView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray3.color
        view.layer.cornerRadius = 6
        return view
    }()
    
    let thirdDotView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray3.color
        view.layer.cornerRadius = 6
        return view
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.backgroundColor = ResourceManager.instance.getMainColor()
        button.titleLabel?.font =  ResourceManager.instance.getFont(size: 18)
        button.setTitle(L10n.next, for: .normal)
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
        return button
    }()
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        progressStackView.addArrangedSubviews([
            firstDotView,
            secondDotView,
            thirdDotView
        ])
        
        addSubviews([
            containerView,
            progressStackView,
            nextButton
        ])
    }
    
    override func initConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(progressStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top)
            make.width.equalToSuperview()
        }
        
        progressStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-15)
            make.centerX.equalToSuperview()
            make.height.equalTo(54)
        }
        
        [firstDotView,
         secondDotView,
         thirdDotView].forEach { view in
            view.snp.makeConstraints { make in
                make.size.equalTo(12)
            }
        }
    }
}
