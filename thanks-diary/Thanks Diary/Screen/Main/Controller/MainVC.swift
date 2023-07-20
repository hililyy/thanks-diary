//
//  MainVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit
import FSCalendar

final class MainVC: BaseVC {
    
    private let mainView = MainView()
    let viewModel = MainViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
        mainView.diaryTableView.delegate = self
        mainView.diaryTableView.dataSource = self
        
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAllData()
    }
    
    private func setTarget() {
        
        // 플로팅 버튼 타겟 설정
        mainView.floatingButton.button.addTarget {
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
        
        // 설정 버튼 타겟 설정
        mainView.settingButton.addTarget {
            self.pushVC(name: "Setting", identifier: "SettingVC")
        }
        
        // 오늘 버튼 타겟 설정
        mainView.todayButton.addTarget {
            self.moveToday()
        }
    }
    
    func getAllData() {
        viewModel.getAllDiaryData {
            self.viewModel.getSelectedDiaryData {
                self.mainView.calendar.reloadData()
                self.mainView.diaryTableView.reloadData()
            }
        }
    }
    
    func getSelectedData() {
        self.viewModel.getSelectedDiaryData {
            self.mainView.diaryTableView.reloadData()
        }
    }
    
    func moveToday() {
        mainView.calendar.select(Date())
        mainView.todayLabel.text = Date().convertString(format: "dd'일' (E)")
        viewModel.selectedDate = Date()
        getSelectedData()
    }
}

extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // 캘린더 날짜 선택시 동작
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        mainView.todayLabel.text = date.convertString(format: "dd'일' (E)")
        viewModel.selectedDate = date
        getSelectedData()
    }
    
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return viewModel.diaryDates.contains(date.convertString()) ? UIImage(named: "ic_circle") : nil
    }
    
    // 날짜 이미지 위치 조정
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: -5.15)
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
                mainView.emptyImageView.isHidden = false
                mainView.emptyImageView.frame.size.height = 300
                mainView.setEmptyImageView(image: UIImage(named: "img_not_today"))
                return 0
            } else {
                mainView.emptyImageView.isHidden = false
                mainView.emptyImageView.frame.size.height = 300
                mainView.setEmptyImageView(image: UIImage(named: "img_not_before"))
                return 0
            }
        } else {
            mainView.emptyImageView.isHidden = true
            mainView.emptyImageView.frame.size.height = 0
            return viewModel.selectedDetailData.count + viewModel.selectedSimpleData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case ..<viewModel.selectedDetailData.count:
            guard let cell = mainView.diaryTableView.dequeueReusableCell(withIdentifier: DetailDiaryTVCell.id, for: indexPath) as? DetailDiaryTVCell else { return UITableViewCell() }
            cell.titleLabel.text = viewModel.selectedDetailData[indexPath.row].title
            return cell
        case viewModel.selectedDetailData.count...:
            guard let cell = mainView.diaryTableView.dequeueReusableCell(withIdentifier: SimpleDiaryTVCell.id, for: indexPath) as? SimpleDiaryTVCell else { return UITableViewCell() }
            cell.titleLabel.text =
            viewModel.selectedSimpleData[indexPath.row - viewModel.selectedDetailData.count].contents
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
