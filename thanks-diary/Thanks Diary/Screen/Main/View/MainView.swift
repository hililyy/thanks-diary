//
//  MainView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/14.
//

import UIKit
import RxSwift
import RxCocoa
import FSCalendar

final class MainView: BaseView {
    
    // MARK: - UI components
    
    let todayButton = UIButton(type: .custom).then { button in
        button.layer.cornerRadius = 10
        button.titleLabel?.font = Font.NANUM_ULTRALIGHT_15
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.setTitleColor(Color.COLOR_GRAY6, for: .normal)
        button.setTitle("text_today".localized, for: .normal)
    }
    
    let settingButton = UIButton(type: .custom).then { button in
        button.setImage(Image.IC_SETTING, for: .normal)
    }
    
    let calendar = FSCalendar().then { calendar in
        calendar.backgroundColor = Color.COLOR_GRAY4
        calendar.appearance.headerTitleColor = Color.COLOR_GRAY1
        calendar.appearance.weekdayTextColor = Color.COLOR_GRAY1
        calendar.appearance.titleDefaultColor = Color.COLOR_GRAY1 // 선택가능한 날짜 색
        calendar.appearance.titlePlaceholderColor = Color.COLOR_WHITE_GRAY // 선택 불가능한 날짜 색
        
        calendar.appearance.headerTitleFont = Font.NANUM_LIGHT_19
        calendar.appearance.weekdayFont = Font.NANUM_ULTRALIGHT_17
        calendar.appearance.titleFont = Font.NANUM_LIGHT_17
        calendar.appearance.subtitleFont = Font.NANUM_ULTRALIGHT_17
        calendar.appearance.todayColor = Color.COLOR_LIGHTGRAYBLUE // 오늘 날짜 동그라미 색상
        calendar.appearance.selectionColor = Color.COLOR_GRAY5
        
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.calendar.headerHeight = 50
        
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.weekdayHeight = 30
        calendar.rowHeight = 40
        calendar.layer.cornerRadius = 10
    }
    
    private let lineViewX = UIView().then { view in
        view.backgroundColor = Color.COLOR_GRAY3
    }
    
    private let topView = UIView() // 오늘, 설정 버튼이 들어가는 뷰
    private let titleView = UIView() // 오늘 날짜 뷰

    private let todayLabel = UILabel().then { label in
        label.font = Font.NANUM_LIGHT_20
        label.textColor = Color.COLOR_GRAY1
        label.textAlignment = .left
        label.text = Date().convertString(format: "dd일 (E)")
    }
    
    let diaryTableView = UITableView().then { tableView in
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.register(DetailDiaryTVCell.self, forCellReuseIdentifier: DetailDiaryTVCell.id)
        tableView.register(SimpleDiaryTVCell.self, forCellReuseIdentifier: SimpleDiaryTVCell.id)
    }
    
    private let emptyImageView = UIImageView().then { view in
        view.contentMode = .scaleAspectFit
    }
    
    let floatingButton = FloatingButton().then { button in
        button.setButtonImage(Image.IC_PENCIL)
        button.setButtonBackgroundColor(Color.COLOR_LIGHTGRAYBLUE)
    }
    
    // MARK: - Functions
    
    func setImageForEmptyView(image: UIImage?) {
        guard let image = image else { return }
        emptyImageView.image = image
    }
    
    func setTodayLabelText(date: Date) {
        todayLabel.text = date.convertString(format: "dd'일' (E)")
    }
    
    func setHiddenForEmptyView(isHidden: Bool) {
        emptyImageView.isHidden = isHidden
        emptyImageView.frame.size.height = isHidden ? 0 : 300
    }
    
    // MARK: - UI, Target
    
    override func configureUI() {
        backgroundColor = Color.COLOR_WHITE
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([topView,
                     calendar,
                     lineViewX,
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
            make.bottom.equalTo(calendar.snp.top).offset(-10)
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
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(lineViewX.snp.top).offset(-15)
            make.height.equalTo(320)
        }
        
        lineViewX.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(titleView.snp.top)
            make.height.equalTo(1)
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
