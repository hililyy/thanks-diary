//
//  MainView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/06/12.
//

import UIKit
import FSCalendar

final class MainView: UIView {
    let todayButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.setTitle("오늘", for: .normal)
        button.titleLabel?.font = Font.NANUM_LIGHT_15
        return button
    }()
    
    let uploadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_upload"), for: .normal)
        return button
    }()
    
    let settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_setting"), for: .normal)
        return button
    }()
    
    let topButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    let calendarView: FSCalendar = {
        let calendar = FSCalendar()
        return calendar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let notWriteImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let todayLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.COLOR_GRAY1
        label.font = Font.NANUM_LIGHT_15
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        addView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        backgroundColor = .white
    }
    
    private func addView() {
        
    }
    
    private func setConstraints() {
        
    }
}
