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

class MainVC: UIViewController {

    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var diaryTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    var container: NSPersistentContainer!
    let model = MainModel.model
    fileprivate var datesWithCat: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.longDiaryFlag = LocalDataStore.localDataStore.getTodayDetailData()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d"
        model.selectedDate = formatter.string(from: Date())
        
//        model.getDetailData(selectedDate: model.selectedDate)
//        model.getSimpleData(selectedDate: model.selectedDate)
        
        self.diaryTableView.delegate = self
        self.diaryTableView.dataSource = self
        setFloty()
        setCalender()
        setTodayDate(selectedData: Date())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        model.getDetailData(selectedDate: model.selectedDate)
        model.getSimpleData(selectedDate: model.selectedDate)
        self.datesWithCat = model.dateList
        calendar.reloadData()
        diaryTableView.reloadData()
    }

    func setFloty() {
        let floaty = Floaty()
        floaty.buttonColor = UIColor(named: "mainColor")!
        floaty.plusColor = UIColor(named: "whiteColor")!
        floaty.addItem("간단하게", icon: UIImage(named: "ic_simple_write")!, handler: { item in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SimpleWriteVC") as? SimpleWriteVC {
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overCurrentContext
                vc.delegate = self
                self.present(vc, animated: true, completion: nil)
            }
                floaty.close()
        })
        floaty.addItem("자세하게", icon: UIImage(named: "ic_detail_write")!, handler: { item in
            if self.model.longDiaryFlag == false {
                guard let vc =  self.storyboard?.instantiateViewController(identifier: "WriteVC") as? WriteVC else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.view.makeToast("자세한 일기는 하루에 한번 작성 가능합니다.")
            }
            floaty.close()
        })
        self.view.addSubview(floaty)
    }
    
    func setTodayDate(selectedData: Date) {
        let formatter = DateFormatter()
        let loc = Locale(identifier: "ko_KR")
        formatter.dateFormat = "dd'일' (E)"
        formatter.locale = loc
        self.todayDate.text = formatter.string(from: selectedData)
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d"
        setTodayDate(selectedData: date)
        model.selectedDate = formatter.string(from: date)
        
        model.getSimpleData(selectedDate: model.selectedDate)
        model.getDetailData(selectedDate: model.selectedDate)
        
        self.diaryTableView.reloadData()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    @IBAction func goSetting(_ sender: Any) {
        guard let vc =  storyboard?.instantiateViewController(identifier: "SettingVC") as? SettingVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func setCalender() {
        self.calendar.delegate = self
        self.calendar.dataSource = self
        self.calendar.locale = Locale(identifier: "ko_KR")
        self.calendar.appearance.headerDateFormat = "YYYY년 M월"
        
        self.calendar.appearance.headerTitleColor = UIColor(named: "grayColor_1")
        self.calendar.appearance.headerTitleFont = UIFont(name: "KOTRA_GOTHIC", size: 19)
        self.calendar.appearance.titleFont = UIFont(name: "KOTRA_GOTHIC", size: 17)
        self.calendar.appearance.weekdayFont = UIFont(name: "KOTRA_GOTHIC", size: 17)
        self.calendar.appearance.subtitleFont = UIFont(name: "KOTRA_GOTHIC", size: 17)
        
        self.calendar.appearance.weekdayTextColor = UIColor(named: "grayColor_1")
        self.calendar.appearance.calendar.headerHeight = 50
        self.calendar.weekdayHeight = 30
        self.calendar.rowHeight = 40
        
    }
        
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let imageDateFormatter = DateFormatter()
        imageDateFormatter.dateFormat = "yyyy-M-d"
        var dateStr = imageDateFormatter.string(from: date)
        return datesWithCat.contains(dateStr) ? UIImage(named: "ic_circle") : nil
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: -5)
    }
}


extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.detailData.count == 0 && model.simpleData.count == 0 {
            self.emptyView.isHidden = false
            self.emptyView.frame.size.height = 299
            diaryTableView.isScrollEnabled = false
            return 0
        } else {
            self.emptyView.isHidden = true
            self.emptyView.frame.size.height = 0
            return model.detailData.count + model.simpleData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && !model.detailData.isEmpty {
            let cell = diaryTableView.dequeueReusableCell(withIdentifier: "DetailDiaryListCell", for: indexPath) as! DetailDiaryListCell
            cell.titleLabel.text = model.detailData[indexPath.row].title
            return cell
        } else {
            if model.detailData.isEmpty {
                let cell = diaryTableView.dequeueReusableCell(withIdentifier: "SimpleDiaryListCell", for: indexPath) as! SimpleDiaryListCell
                cell.titleLabel.text = model.simpleData[indexPath.row].contents
                return cell
            } else {
                let cell = diaryTableView.dequeueReusableCell(withIdentifier: "SimpleDiaryListCell", for: indexPath) as! SimpleDiaryListCell
                cell.titleLabel.text = model.simpleData[indexPath.row-1].contents
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index : \(indexPath.row)")
        if model.longDiaryFlag == true {
            if indexPath.row == 0 {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReadVC") as? ReadVC {
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    vc.selectedDataDate = model.detailData[0].date ?? ""
                    vc.selectedDataTitle = model.detailData[0].title ?? ""
                    vc.selectedDataContents = model.detailData[0].contents ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SimpleWriteVC") as? SimpleWriteVC {
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overCurrentContext
                    vc.updateFlag = true
                    vc.contentsString = model.simpleData[indexPath.row-1].contents ?? ""
                    vc.delegate = self
                    self.present(vc, animated: true, completion: nil)
                }
            }
        } else {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SimpleWriteVC") as? SimpleWriteVC {
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overCurrentContext
                vc.updateFlag = true
                vc.contentsString = model.simpleData[indexPath.row].contents ?? ""
                vc.delegate = self
                self.present(vc, animated: true, completion: nil)
            }
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

extension MainVC: reloadDelegate {
    func reloadData() {
        model.getDetailData(selectedDate: model.selectedDate)
        model.getSimpleData(selectedDate: model.selectedDate)
        self.datesWithCat = model.dateList
        calendar.reloadData()
        diaryTableView.reloadData()
    }
}
