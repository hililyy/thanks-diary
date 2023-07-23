//
//  MainView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/14.
//

import UIKit
import FSCalendar

final class MainView: BaseView {
    
    var todayButton = UIButton(type: .custom).then { button in
        button.layer.cornerRadius = 10
        button.titleLabel?.font = Font.NANUM_ULTRALIGHT_15
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        button.setTitle("text_today".localized, for: .normal)
    }
    
    var settingButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_SETTING, for: .normal)
    }
    
    var calendar = FSCalendar().then { calendar in
        calendar.backgroundColor = .white
        calendar.appearance.todayColor = Color.COLOR_LIGHTGRAYBLUE
        calendar.appearance.selectionColor = Color.COLOR_GRAY3
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        
        calendar.appearance.headerTitleColor = Color.COLOR_GRAY1
        calendar.appearance.headerTitleFont = Font.NANUM_ULTRALIGHT_19
        calendar.appearance.titleFont = Font.NANUM_ULTRALIGHT_17
        calendar.appearance.weekdayFont = Font.NANUM_ULTRALIGHT_17
        calendar.appearance.subtitleFont = Font.NANUM_ULTRALIGHT_17
        
        calendar.appearance.weekdayTextColor = Color.COLOR_GRAY1
        calendar.appearance.calendar.headerHeight = 50
        calendar.weekdayHeight = 30
        calendar.rowHeight = 40
    }
    
    var topView = UIView() // 오늘, 설정 버튼이 들어가는 뷰
    var titleView = UIView() // 오늘 날짜 뷰

    var todayLabel = UILabel().then { label in
        label.font = Font.NANUM_ULTRALIGHT_20
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .left
        label.text = Date().convertString(format: "dd일 (E)")
    }
    
    var diaryTableView = UITableView().then { view in
        view.rowHeight = 60
        view.separatorColor = .clear
        view.separatorStyle = .none
        view.register(DetailDiaryTVCell.self, forCellReuseIdentifier: DetailDiaryTVCell.id)
        view.register(SimpleDiaryTVCell.self, forCellReuseIdentifier: SimpleDiaryTVCell.id)
    }
    
    var emptyImageView = UIImageView().then { view in
        view.contentMode = .scaleAspectFit
    }
    
    var floatingButton = FloatingButton().then { button in
        button.setButtonImage(Image.IC_PENCIL)
        button.setButtonBackgroundColor(Color.COLOR_LIGHTGRAYBLUE)
    }
    
    func setEmptyImageView(image: UIImage?) {
        guard let image = image else { return }
        emptyImageView.image = image
    }
    
    func setTodayLabelText(date: Date) {
        todayLabel.text = date.convertString(format: "dd'일' (E)")
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
