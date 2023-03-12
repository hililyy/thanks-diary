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
import Toast_Swift
import Firebase

class MainVC: UIViewController {

    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var diaryTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet var todayBtn: UIButton!
    
    let model = MainModel.model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.diaryTableView.delegate = self
        self.diaryTableView.dataSource = self
        self.todayBtn.layer.cornerRadius = 10
        self.todayDate.text = Date().convertString(format: "dd'일' (E)")
        setFloty()
        setCalender()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        reloadData()
    }
    
    @IBAction func goSetting(_ sender: Any) {
        self.showSettingVC()
    }
    
    @IBAction func moveTodayFocus(_ sender: Any) {
        self.calendar.select(Date())
        model.selectedDate = Date()
        self.todayDate.text = Date().convertString(format: "dd'일' (E)")
        changeDatabyDate()
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
    
    func changeDatabyDate() {
        model.getDetailData() {
            self.model.getSimpleData() {
                self.diaryTableView.reloadData()
            }
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.longData.count == 0 && model.shortData.count == 0 {
            if  self.model.selectedDate.convertString() == Date().convertString() {
                self.emptyView.isHidden = false
                self.emptyView.frame.size.height = 300
                self.emptyImage.image = UIImage(named: "img_not_today")
                return 0
            } else {
                self.emptyView.isHidden = false
                self.emptyView.frame.size.height = 300
                self.emptyImage.image = UIImage(named: "img_not_before")
                return 0
            }
        } else {
            self.emptyView.isHidden = true
            self.emptyView.frame.size.height = 0
            return model.longData.count + model.shortData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case ..<model.longData.count:
            let cell = diaryTableView.dequeueReusableCell(withIdentifier: "DetailDiaryListCell", for: indexPath) as! DetailDiaryListCell
            cell.titleLabel.text = model.longData[indexPath.row].title
            cell.selectionStyle = .none
            return cell
        case model.longData.count...:
            let cell = diaryTableView.dequeueReusableCell(withIdentifier: "SimpleDiaryListCell", for: indexPath) as! SimpleDiaryListCell
            cell.titleLabel.text =
            model.shortData[indexPath.row-model.longData.count].contents
            cell.selectionStyle = .none
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case ..<model.longData.count:
            showReadVC(index: indexPath.row)
        case model.longData.count...:
            showSimpleWriteVC(isEdit: true,selectedIndex: indexPath.row - model.longData.count)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
        model.selectedDate = date
        self.todayDate.text = date.convertString(format: "dd'일' (E)")
        changeDatabyDate()
    }
        
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return model.dateWithCircle.contains(date.convertString()) ? UIImage(named: "ic_circle") : nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: -5)
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}

extension MainVC: reloadDelegate {
    func reloadData() {
        model.getDetailData() {
            self.model.getSimpleData() {
                self.calendar.reloadData()
                self.diaryTableView.reloadData()
            }
        }
    }
}
