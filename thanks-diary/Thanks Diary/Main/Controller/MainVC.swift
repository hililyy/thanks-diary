//
//  MainVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit
import FSCalendar
import Floaty
import CoreData
import Firebase

final class MainVC: UIViewController {
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var diaryTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var todayBtn: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    
    let mainModel = MainModel.model
    var diaryTableViewModel: DiaryTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryTableViewModel = DiaryTableView(self)
        diaryTableView.delegate = diaryTableViewModel
        diaryTableView.dataSource = diaryTableViewModel
        self.todayBtn.layer.cornerRadius = 10
        self.todayDate.text = mainModel.selectedDate.convertString(format: "dd'일' (E)")
        setFloty()
        setCalender()
        setuploadBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if mainModel.loginType == LoginType.none {
            reloadData()
        } else {
            reloadFirebaseData()
        }
    }
    
    @IBAction func goSetting(_ sender: UIButton) {
        self.showSettingVC()
    }
    
    @IBAction func moveTodayFocus(_ sender: UIButton) {
        self.calendar.select(Date())
        self.todayDate.text = Date().convertString(format: "dd'일' (E)")
        mainModel.selectedDate = Date()
        if mainModel.loginType == LoginType.none {
            reloadDataAndTableView()
        } else {
            reloadFirebaseAndTableView()
        }
    }
    
    @IBAction func uploadData(_ sender: UIButton) {
        AlertManager.shared.setAlert(self, title: "알림", message: "백업되지 않은 데이터가 있으면 백업합니다.") {
            self.mainModel.uploadData()
            self.reloadFirebaseData()
        }
    }
    
    func setuploadBtn() {
        if mainModel.loginType != LoginType.none {
            self.uploadBtn.isHidden = false
        } else {
            self.uploadBtn.isHidden = true
        }
    }
    
    func setFloty() {
        let floaty = Floaty()
        floaty.buttonColor = UIColor(named: "mainColor")!
        floaty.plusColor = UIColor(named: "whiteColor")!
        floaty.addItem("간단하게", icon: UIImage(named: "ic_simple_write")!, handler: { item in
            self.showSimpleWriteVC()
            floaty.close()
        })
        floaty.addItem("자세하게", icon: UIImage(named: "ic_detail_write")!, handler: { item in
            self.showDetailWriteVC()
            floaty.close()
        })
        self.view.addSubview(floaty)
    }
    
    func reloadDataAndTableView() {
        mainModel.getData() {
            self.diaryTableView.reloadData()
        }
    }
    
    func reloadFirebaseAndTableView() {
        mainModel.getFirebaseData {
            self.diaryTableView.reloadData()
        }
    }
    
    func setDataByDate() {
        mainModel.setDataByDate()
        self.diaryTableView.reloadData()
    }
}

extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 캘린더 기본 UI 셋팅
    func setCalender() {
        self.calendar.delegate = self
        self.calendar.dataSource = self
        self.calendar.locale = Locale(identifier: "ko_KR")
        self.calendar.appearance.headerDateFormat = "YYYY년 M월"
        
        self.calendar.appearance.headerTitleColor = UIColor(named: "grayColor_1")
        self.calendar.appearance.headerTitleFont = UIFont(name: "NanumBarunGothicUltraLight", size: 19)
        self.calendar.appearance.titleFont = UIFont(name: "NanumBarunGothicUltraLight", size: 17)
        self.calendar.appearance.weekdayFont = UIFont(name: "NanumBarunGothicUltraLight", size: 17)
        self.calendar.appearance.subtitleFont = UIFont(name: "NanumBarunGothicUltraLight", size: 17)
        
        self.calendar.appearance.weekdayTextColor = UIColor(named: "grayColor_1")
        self.calendar.appearance.calendar.headerHeight = 50
        self.calendar.weekdayHeight = 30
        self.calendar.rowHeight = 40
    }
    
    // 캘린더 날짜 선택시 동작
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.todayDate.text = date.convertString(format: "dd'일' (E)")
        mainModel.selectedDate = date
        if mainModel.loginType == LoginType.none {
            reloadDataAndTableView()
        } else {
            setDataByDate()
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
}

extension MainVC: reloadDelegate, reloadFirebaseDelegate {
    func reloadData() {
        mainModel.getData() {
            self.calendar.reloadData()
            self.diaryTableView.reloadData()
        }
    }
    
    func reloadFirebaseData() {
        mainModel.getFirebaseData {
            self.setDataByDate()
            self.calendar.reloadData()
            self.diaryTableView.reloadData()
        }
    }
}
