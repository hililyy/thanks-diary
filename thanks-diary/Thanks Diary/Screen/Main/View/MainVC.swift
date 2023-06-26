//
//  MainVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit
import FSCalendar
import CoreData
import Toast_Swift

class MainVC: BaseVC {

    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var diaryTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyImage: UIImageView!
    
    let model = MainModel.model
    private let floatingButton = FloatingButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        model.longDiaryFlag = LocalDataStore.localDataStore.getTodayDetailData()
        model.selectedDate = model.isTodayDateString()
        model.todayDate = model.isTodayDateString()
        
        self.diaryTableView.delegate = self
        self.diaryTableView.dataSource = self
        
        floatingConstraints()
        setCalender()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        model.getDetailData(selectedDate: model.selectedDate)
        model.getSimpleData(selectedDate: model.selectedDate)
        self.datesWithCircle = model.dateList
        calendar.reloadData()
        diaryTableView.reloadData()
    }
    
    func initialize() {
        self.todayDate.text = model.setTodayDate(selectedData: Date())
    }
    
    @IBAction func goSetting(_ sender: Any) {
        self.goSettingVC()
    }
    
    func floatingConstraints() {
        let floatingButton = FloatingButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        floatingButton.setButtonImage(UIImage(named: "ic_pencil"))
        floatingButton.setButtonBackgroundColor(Color.COLOR_LIGHTGRAYBLUE)

        floatingButton.button.addTarget { [weak self] _ in
            guard let self = self else { return }
            let vc = FloatingButtonVC()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: false)
        }
        
        view.addSubview(floatingButton)
        
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            floatingButton.widthAnchor.constraint(equalToConstant: 52),
            floatingButton.heightAnchor.constraint(equalToConstant: 52)
        ])

        floatingButton.setView()
    }
    
    
    
    func goSimpleWriteVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SimpleWriteVC") as? SimpleWriteVC else { return }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
    }
    
    func goDetailWriteVC() {
        guard let vc =  self.storyboard?.instantiateViewController(identifier: "DetailWriteVC") as? DetailWriteVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goSettingVC() {
        guard let vc =  storyboard?.instantiateViewController(identifier: "SettingVC") as? SettingVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goReadVC() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReadVC") as? ReadVC {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.selectedDataDate = model.detailData[0].date ?? ""
            vc.selectedDataTitle = model.detailData[0].title ?? ""
            vc.selectedDataContents = model.detailData[0].contents ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func goSimpleWriteVC(index: Int) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SimpleWriteVC") as? SimpleWriteVC {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.updateFlag = true
            vc.contentsString = model.simpleData[index].contents ?? ""
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.detailData.count == 0 && model.simpleData.count == 0 {
            if self.model.todayDate == self.model.selectedDate {
                self.emptyView.isHidden = false
                self.emptyView.frame.size.height = 299
                self.emptyImage.image = UIImage(named: "img_not_today")
//                LocalDataStore.localDataStore.setTodayDetailData(newData: false)
                return 0
            } else {
                self.emptyView.isHidden = false
                self.emptyView.frame.size.height = 299
                self.emptyImage.image = UIImage(named: "img_not_before")
                return 0
            }
        } else {
            self.emptyView.isHidden = true
            self.emptyView.frame.size.height = 0
            return model.detailData.count + model.simpleData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        do {
            if indexPath.row == 0 && model.longDiaryFlag == true {
                let cell = diaryTableView.dequeueReusableCell(withIdentifier: "DetailDiaryListCell", for: indexPath) as! DetailDiaryListCell
                cell.titleLabel.text = model.detailData[0].title
                cell.selectionStyle = .none
                return cell
            } else {
                if model.longDiaryFlag == true {
                    let cell = diaryTableView.dequeueReusableCell(withIdentifier: "SimpleDiaryListCell", for: indexPath) as! SimpleDiaryListCell
                    cell.titleLabel.text = model.simpleData[indexPath.row-1].contents
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = diaryTableView.dequeueReusableCell(withIdentifier: "SimpleDiaryListCell", for: indexPath) as! SimpleDiaryListCell
                    cell.titleLabel.text = model.simpleData[indexPath.row].contents
                    cell.selectionStyle = .none
                    return cell
                }
            }
        } catch {
            print(ErrorCase.NOT_EXIST_INDEX)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if model.longDiaryFlag == true {
            if indexPath.row == 0 {
                goReadVC()
            } else {
                goSimpleWriteVC(index: indexPath.row-1)
            }
        } else {
            goSimpleWriteVC(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if model.longDiaryFlag == true {
            if indexPath.row == 0 {
                return 55
            } else {
                return 42
            }
        } else {
            return 42
        }
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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d"
        self.todayDate.text = model.setTodayDate(selectedData: date)
        model.selectedDate = formatter.string(from: date)
        
        model.getSimpleData(selectedDate: model.selectedDate)
        model.getDetailData(selectedDate: model.selectedDate)
        
        self.diaryTableView.reloadData()
    }
        
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let imageDateFormatter = DateFormatter()
        imageDateFormatter.dateFormat = "yyyy-M-d"
        var dateStr = imageDateFormatter.string(from: date)
        return datesWithCircle.contains(dateStr) ? UIImage(named: "ic_circle") : nil
        
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
        model.getDetailData(selectedDate: model.selectedDate)
        model.getSimpleData(selectedDate: model.selectedDate)
        self.datesWithCircle = model.dateList
        calendar.reloadData()
        diaryTableView.reloadData()
    }
}
