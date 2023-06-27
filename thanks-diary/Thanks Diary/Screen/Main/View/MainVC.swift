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

final class MainVC: BaseVC {

    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var diaryTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyImage: UIImageView!
    
    let viewModel = MainViewModel()
    private let floatingButton = FloatingButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        diaryTableView.delegate = self
        diaryTableView.dataSource = self
        
        floatingConstraints()
        setCalender()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllData()
    }
    
    func initialize() {
        todayLabel.text = viewModel.selectedDate.convertString(format: "dd일 (E)")
        todayButton.layer.cornerRadius = 10
    }
    
    @IBAction func goSetting(_ sender: UIButton) {
        pushVC(name: "Setting", identifier: "SettingVC")
    }
    
    @IBAction func moveTodayFocus(_ sender: UIButton) {
        moveToday()
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
            vc.detailHandler = {
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailWriteVC") as? DetailWriteVC else { return }
                vc.parentVC = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            vc.simpleHandler = {
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SimpleWriteVC") as? SimpleWriteVC else { return }
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                vc.parentVC = self
                vc.delegate = self
                vc.updateFlag = false
                self.present(vc, animated: true)
            }
            
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
    
    func getAllData() {
        viewModel.getAllDiaryData {
            self.viewModel.getSelectedDiaryData {
                self.calendar.reloadData()
                self.diaryTableView.reloadData()
            }
        }
    }
    
    func getSelectedData() {
        self.viewModel.getSelectedDiaryData {
            self.diaryTableView.reloadData()
        }
    }
    
    func moveToday() {
        calendar.select(Date())
        todayLabel.text = Date().convertString(format: "dd'일' (E)")
        viewModel.selectedDate = Date()
        getSelectedData()
    }
}

extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 캘린더 기본 UI 셋팅
    func setCalender() {
        
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
    
    // 캘린더 날짜 선택시 동작
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        todayLabel.text = date.convertString(format: "dd'일' (E)")
        viewModel.selectedDate = date
        getSelectedData()
    }
    
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return viewModel.diaryDates.contains(date.convertString()) ? UIImage(named: "ic_circle") : nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: -5)
    }
    
    // 최대 선택 가능 날짜
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.selectedDetailData.isEmpty && viewModel.selectedSimpleData.isEmpty {
            if  viewModel.selectedDate.convertString() == Date().convertString() {
                emptyView.isHidden = false
                emptyView.frame.size.height = 300
                emptyImage.image = UIImage(named: "img_not_today")
                return 0
            } else {
                emptyView.isHidden = false
                emptyView.frame.size.height = 300
                emptyImage.image = UIImage(named: "img_not_before")
                return 0
            }
        } else {
            emptyView.isHidden = true
            emptyView.frame.size.height = 0
            return viewModel.selectedDetailData.count + viewModel.selectedSimpleData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case ..<viewModel.selectedDetailData.count:
            let cell = diaryTableView.dequeueReusableCell(withIdentifier: "DetailDiaryListCell", for: indexPath) as! DetailDiaryListCell
            cell.titleLabel.text = viewModel.selectedDetailData[indexPath.row].title
            cell.selectionStyle = .none
            return cell
        case viewModel.selectedDetailData.count...:
            let cell = diaryTableView.dequeueReusableCell(withIdentifier: "SimpleDiaryListCell", for: indexPath) as! SimpleDiaryListCell
            cell.titleLabel.text =
            viewModel.selectedSimpleData[indexPath.row - viewModel.selectedDetailData.count].contents
            cell.selectionStyle = .none
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case ..<viewModel.selectedDetailData.count:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReadVC") as? ReadVC else { return }
            viewModel.selectedDate = viewModel.selectedDetailData[indexPath.row].date?.convertDate() ?? Date()
            vc.parentVC = self
            vc.selectedIndex = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
            
        case viewModel.selectedDetailData.count...:
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SimpleWriteVC") as? SimpleWriteVC else { return }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.parentVC = self
            vc.selectedIndex = indexPath.row - viewModel.selectedDetailData.count
            vc.delegate = self
            vc.updateFlag = true
            self.present(vc, animated: true)
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension MainVC: reloadDelegate {
    func reloadData() {
        getAllData()
    }
}
