//
//  SearchTVCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/12/05.
//

import UIKit

final class SearchTVCell: BaseTVCell, CellIdentifier {
    
    // MARK: - UI components
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 10)
        label.textColor = Asset.Color.gray1.color
        label.numberOfLines = 1
        return label
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 17)
        label.textColor = Asset.Color.gray1.color
        label.numberOfLines = 1
        return label
    }()
    
    func setContentsLabelStyle(searchText: String, contentsLabelText: String) {
        contentsLabel.setHighlightText(
            basicText: contentsLabelText,
            basicTextColor: Asset.Color.gray1.color,
            highlightText: searchText,
            highlightTextColor: ResourceManager.instance.getMainDeepColor(),
            font: ResourceManager.instance.getFont(size: 17)
        )
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    override func initSubviews() {
        contentView.addSubviews([
            dateLabel,
            contentsLabel
        ])
    }
    
    override func initConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(15)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalToSuperview().inset(15)
        }
    }
}
