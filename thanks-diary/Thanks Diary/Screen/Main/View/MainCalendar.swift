//
//  MainCalendar.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/22.
//

import UIKit
import FSCalendar

final class MainCalendar: NSObject {
    private var mainVC: MainVC
    private let mainModel = MainModel.model
    
    init(_ mainVC: MainVC) {
        self.mainVC = mainVC
    }
}

extension MainCalendar: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 캘린더 기본 UI 셋팅
    func setCalender() {
        
        mainVC.calendar.locale = Locale(identifier: "ko_KR")
        mainVC.calendar.appearance.headerDateFormat = "YYYY년 M월"
        
        mainVC.calendar.appearance.headerTitleColor = UIColor(named: "grayColor_1")
        mainVC.calendar.appearance.headerTitleFont = UIFont(name: "NanumBarunGothicUltraLight", size: 19)
        mainVC.calendar.appearance.titleFont = UIFont(name: "NanumBarunGothicUltraLight", size: 17)
        mainVC.calendar.appearance.weekdayFont = UIFont(name: "NanumBarunGothicUltraLight", size: 17)
        mainVC.calendar.appearance.subtitleFont = UIFont(name: "NanumBarunGothicUltraLight", size: 17)
        
        mainVC.calendar.appearance.weekdayTextColor = UIColor(named: "grayColor_1")
        mainVC.calendar.appearance.calendar.headerHeight = 50
        mainVC.calendar.weekdayHeight = 30
        mainVC.calendar.rowHeight = 40
    }
    
    // 캘린더 날짜 선택시 동작
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        mainVC.todayDate.text = date.convertString(format: "dd'일' (E)")
        mainModel.selectedDate = date
        if mainModel.loginType == LoginType.none {
            //dddd
            mainVC.getDataReloadTableView(type: "coredata")
        } else {
            mainVC.getDataReloadTableView(type: "databydate")
        }
    }
    
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return mainModel.dateWithCircle.contains(date.convertString()) ? UIImage(named: "ic_circle") : nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: -5)
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func moveToday() {
        mainVC.calendar.select(Date())
        mainVC.todayDate.text = Date().convertString(format: "dd'일' (E)")
        mainModel.selectedDate = Date()
        if mainModel.loginType == LoginType.none {
            mainVC.getDataReloadTableView(type: "coredata")
        } else {
            mainVC.getDataReloadTableView(type: "firebase")
        }
    }
}
