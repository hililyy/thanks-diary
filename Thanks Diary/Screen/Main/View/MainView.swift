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
    
    let todayButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = ResourceManager.instance.getFont(size: 15)
        button.backgroundColor = ResourceManager.instance.getMainColor()
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
        button.setTitle(L10n.today, for: .normal)
        return button
    }()
    
    let allButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icAll.image, for: .normal)
        return button
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icSearch.image, for: .normal)
        return button
    }()
    
    let settingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Image.icSetting.image, for: .normal)
        button.accessibilityIdentifier = "button_main_setting"
        return button
    }()
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.backgroundColor = Asset.Color.gray4.color
        calendar.appearance.headerTitleColor = Asset.Color.gray1.color
        calendar.appearance.weekdayTextColor = Asset.Color.gray1.color
        calendar.appearance.titleDefaultColor = Asset.Color.gray1.color // 선택가능한 날짜 색
        calendar.appearance.titlePlaceholderColor = Asset.Color.gray8.color // 선택 불가능한 날짜 색
        calendar.appearance.todayColor = ResourceManager.instance.getMainColor() // 오늘 날짜 동그라미 색상
        calendar.appearance.selectionColor = Asset.Color.gray5.color
        calendar.appearance.titleTodayColor = Asset.Color.gray6.color
        
        calendar.appearance.headerTitleFont = ResourceManager.instance.getFont(size: 19)
        calendar.appearance.weekdayFont = ResourceManager.instance.getFont(size: 17)
        calendar.appearance.titleFont = ResourceManager.instance.getFont(size: 17)
        calendar.appearance.subtitleFont = ResourceManager.instance.getFont(size: 17)
        
        calendar.appearance.headerDateFormat = L10n.formatDate3
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.calendar.headerHeight = 50
        
        calendar.locale = Locale(identifier: DateFormat.LOCAL_IDENTIFIER.rawValue)
        calendar.weekdayHeight = 30
        calendar.rowHeight = 40
        calendar.layer.cornerRadius = 10
        return calendar
    }()
    
    private let lineViewX: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray3.color
        return view
    }()
    
    private let todayAndSettingTopView = UIView()
    private let todayLabelView = UIView()

    private let todayLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceManager.instance.getFont(size: 20)
        label.textColor = Asset.Color.gray1.color
        label.textAlignment = .left
        label.text = Date().toString(didChangeDateFormat: L10n.formatDate2)
        return label
    }()
    
    let diaryTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.register(DetailDiaryTVCell.self, forCellReuseIdentifier: DetailDiaryTVCell.id)
        tableView.register(SimpleDiaryTVCell.self, forCellReuseIdentifier: SimpleDiaryTVCell.id)
        tableView.accessibilityIdentifier = "tableView_main"
        return tableView
    }()
    
    let emptyView = UIView()
    
    let floatingButton: FloatingButton = {
        let button = FloatingButton()
        button.setButtonImage(img: Asset.Image.icPencil.image,
                              color: Asset.Color.cleanWhite.color)
        button.setButtonBackgroundColor(ResourceManager.instance.getMainColor())
        button.button.accessibilityIdentifier = "button_main_floating"
        return button
    }()
    
    // MARK: - Functions
    
    func setEmptyView(view: UIView) {
        emptyView.removeAllSubViews()
        emptyView.addSubview(view)
        view.setAutoLayout(to: emptyView)
    }
    
    func setTodayLabelText(date: Date) {
        AnimationManager.animationPop(view: todayLabelView)
        todayLabel.text = date.toString(didChangeDateFormat: L10n.formatDate2)
    }
    
    func setHiddenForEmptyView(isHidden: Bool) {
        AnimationManager.animationFadeIn(view: emptyView)
        emptyView.isHidden = isHidden
    }
    
    func initAllFont() {
        todayButton.titleLabel?.font = ResourceManager.instance.getFont(size: 15)
        todayLabel.font = ResourceManager.instance.getFont(size: 20)
        calendar.appearance.headerTitleFont = ResourceManager.instance.getFont(size: 19)
        calendar.appearance.weekdayFont = ResourceManager.instance.getFont(size: 17)
        calendar.appearance.titleFont = ResourceManager.instance.getFont(size: 17)
        calendar.appearance.subtitleFont = ResourceManager.instance.getFont(size: 17)
    }
    
    func initAllColor() {
        todayButton.backgroundColor = ResourceManager.instance.getMainColor()
        calendar.appearance.todayColor = ResourceManager.instance.getMainColor()
        floatingButton.setButtonBackgroundColor(ResourceManager.instance.getMainColor())
    }
    
    // MARK: - UI, Target
    
    override func initUI() {
        backgroundColor = Asset.Color.white.color
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            todayAndSettingTopView,
            calendar,
            lineViewX,
            todayLabelView,
            diaryTableView,
            emptyView,
            floatingButton
        ])
        
        todayAndSettingTopView.addSubviews([
            allButton,
            searchButton,
            todayButton,
            settingButton
        ])
        
        todayLabelView.addSubview(todayLabel)
    }
    
    override func initConstraints() {
        todayAndSettingTopView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(calendar.snp.top).offset(-10)
            make.height.equalTo(52)
        }
        
        todayButton.snp.makeConstraints { make in
            make.leading.equalTo(todayAndSettingTopView).offset(20)
            make.bottom.equalTo(todayAndSettingTopView)
            make.width.equalTo(45)
            make.height.equalTo(35)
        }
        
        allButton.snp.makeConstraints { make in
            make.trailing.equalTo(searchButton.snp.leading).offset(-5)
            make.centerY.equalTo(todayButton)
            make.size.equalTo(42)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalTo(settingButton.snp.leading).offset(-5)
            make.centerY.equalTo(todayButton)
            make.size.equalTo(42)
        }
        
        settingButton.snp.makeConstraints { make in
            make.trailing.equalTo(todayAndSettingTopView).offset(-10)
            make.centerY.equalTo(todayButton)
            make.size.equalTo(42)
        }
        
        calendar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(lineViewX.snp.top).offset(-15)
            make.height.equalTo(320)
        }
        
        lineViewX.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(todayLabelView.snp.top)
            make.height.equalTo(1)
        }
        
        todayLabelView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        todayLabel.snp.makeConstraints { make in
            make.leading.equalTo(todayLabelView).offset(25)
            make.centerY.equalTo(todayLabelView)
        }
        
        diaryTableView.snp.makeConstraints { make in
            make.top.equalTo(todayLabelView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        emptyView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(diaryTableView)
            make.horizontalEdges.equalTo(diaryTableView).inset(30)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(40)
            make.size.equalTo(52)
        }
    }
}
