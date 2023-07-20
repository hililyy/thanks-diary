//
//  MainView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/14.
//

import UIKit
import FSCalendar

final class MainView: BaseView {
    
    var todayButton = UIButton(type: .custom).then {
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = Font.NANUM_ULTRALIGHT_15
        $0.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        $0.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        $0.setTitle("오늘", for: .normal)
    }
    
    var settingButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "ic_setting"), for: .normal)
    }
    
    var calendar = FSCalendar().then {
        $0.backgroundColor = .white
        $0.appearance.todayColor = Color.COLOR_LIGHTGRAYBLUE
        $0.appearance.selectionColor = Color.COLOR_GRAY3
        $0.locale = Locale(identifier: "ko_KR")
        $0.appearance.headerDateFormat = "YYYY년 M월"
        
        $0.appearance.headerTitleColor = Color.COLOR_GRAY1
        $0.appearance.headerTitleFont = Font.NANUM_ULTRALIGHT_19
        $0.appearance.titleFont = Font.NANUM_ULTRALIGHT_17
        $0.appearance.weekdayFont = Font.NANUM_ULTRALIGHT_17
        $0.appearance.subtitleFont = Font.NANUM_ULTRALIGHT_17
        
        $0.appearance.weekdayTextColor = Color.COLOR_GRAY1
        $0.appearance.calendar.headerHeight = 50
        $0.weekdayHeight = 30
        $0.rowHeight = 40
    }
    
    var topView = UIView() // 오늘, 설정 버튼이 들어가는 뷰
    var titleView = UIView() // 오늘 날짜 뷰

    var todayLabel = UILabel().then {
        $0.font = Font.NANUM_ULTRALIGHT_20
        $0.textColor = Color.COLOR_GRAY1
        $0.textAlignment = .left
    }
    
    var diaryTableView = UITableView().then {
        $0.separatorColor = .clear
        $0.separatorStyle = .none
        $0.register(DetailDiaryTVCell.self, forCellReuseIdentifier: DetailDiaryTVCell.id)
        $0.register(SimpleDiaryTVCell.self, forCellReuseIdentifier: SimpleDiaryTVCell.id)
    }
    
    var emptyImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    var floatingButton = FloatingButton().then {
        $0.setButtonImage(UIImage(named: "ic_pencil"))
        $0.setButtonBackgroundColor(Color.COLOR_LIGHTGRAYBLUE)
    }
    
    func setEmptyImageView(image: UIImage?) {
        guard let image = image else { return }
        emptyImageView.image = image
    }
    
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func addSubView() {
        addSubviews([topView,
                     calendar,
                     titleView,
                     diaryTableView,
                     emptyImageView,
                     floatingButton])
        topView.addSubviews([todayButton, settingButton])
        titleView.addSubview(todayLabel)
    }
    
    override func setConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(calendar.snp.top)
            make.height.equalTo(52)
        }
        
        todayButton.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(35)
            make.left.equalTo(topView.snp.left).offset(20)
            make.bottom.equalTo(topView.snp.bottom)
        }
        
        settingButton.snp.makeConstraints { make in
            make.width.equalTo(52)
            make.height.equalTo(52)
            make.top.equalTo(topView.snp.top)
            make.right.equalTo(topView.snp.right).offset(-10)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(titleView.snp.top)
            make.height.equalTo(320)
        }
        
        titleView.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.height.equalTo(50)
        }
        
        todayLabel.snp.makeConstraints { make in
            make.left.equalTo(titleView.snp.left).offset(25)
            make.centerY.equalTo(titleView.snp.centerY)
        }
        
        diaryTableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(diaryTableView.snp.top)
            make.left.equalTo(diaryTableView.snp.left).offset(30)
            make.right.equalTo(diaryTableView.snp.right).offset(-30)
            make.bottom.equalTo(diaryTableView.snp.bottom)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.right.equalTo(snp.right).offset(-40)
            make.bottom.equalTo(snp.bottom).offset(-40)
            make.width.equalTo(52)
            make.height.equalTo(52)
        }
    }
}
