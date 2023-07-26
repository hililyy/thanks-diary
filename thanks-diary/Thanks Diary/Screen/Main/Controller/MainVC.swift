//
//  MainVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit
import FSCalendar
import RxSwift
import RxCocoa

final class MainVC: BaseVC {
    
    // MARK: - Property
    
    private let mainView = MainView()
    let viewModel = MainViewModel()
    
    // MARK:- Life Cycle
    
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
    
    // MARK: - Function
    
    private func setTarget() {
        
        // 플로팅 버튼 핸들러 설정
        mainView.floatingButtonTapHandler = {
            let vc = FloatingButtonVC()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.detailHandler = {
                let vc = DetailWriteVC()
                vc.parentVC = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            vc.simpleHandler = {
                let vc = SimpleWriteVC()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                vc.parentVC = self
                vc.delegate = self
                vc.updateFlag = false
                self.present(vc, animated: true)
            }
            
            self.present(vc, animated: false)
        }
        
        // 설정 버튼 핸들러 설정
        mainView.settingButtonTapHandler = {
            let vc = SettingVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // 오늘 버튼 핸들러 설정
        mainView.todayButtonTapHandler = {
            self.moveToday()
        }
    }
    
    // 모든 일기 데이터 셋팅
    private func getAllData() {
        viewModel.getAllDiaryData {
            self.viewModel.getSelectedDiaryData {
                self.mainView.calendar.reloadData()
                self.mainView.diaryTableView.reloadData()
            }
        }
    }
    
    // 선택한 날짜에 해당하는 데이터 셋팅
    private func getSelectedData() {
        self.viewModel.getSelectedDiaryData {
            self.mainView.diaryTableView.reloadData()
        }
    }
    
    // 오늘 날짜로 이동
    private func moveToday() {
        mainView.calendar.select(Date())
        mainView.setTodayLabelText(date: Date())
        viewModel.selectedDate = Date()
        getSelectedData()
    }
}

// MARK: - FSCalendar

extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // 캘린더 날짜 선택시 동작
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        mainView.setTodayLabelText(date: date)
        viewModel.selectedDate = date
        getSelectedData()
    }
    
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return viewModel.diaryDates.contains(date.convertString()) ? Image.IC_CIRCLE : nil
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

// MARK: - UITableView

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 작성한 일기가 없으면 일기 작성 이미지 노출
        if viewModel.selectedDetailData.isEmpty && viewModel.selectedSimpleData.isEmpty {
            mainView.setHiddenForEmptyView(isHidden: false)
            
            if  viewModel.selectedDate.convertString() == Date().convertString() {
                mainView.setImageForEmptyView(image: Image.IMG_NOT_TODAY)
                return 0
            } else {
                mainView.setImageForEmptyView(image: Image.IMG_NOT_BEFORE)
            }
            
            return 0
        
        // 일기 데이터 셋팅
        } else {
            mainView.setHiddenForEmptyView(isHidden: true)
            
            return viewModel.selectedDetailData.count + viewModel.selectedSimpleData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        
        // 자세한 일기
        case ..<viewModel.selectedDetailData.count:
            guard let cell = mainView.diaryTableView.dequeueReusableCell(withIdentifier: DetailDiaryTVCell.id, for: indexPath) as? DetailDiaryTVCell else { return UITableViewCell() }
            cell.titleLabel.text = viewModel.selectedDetailData[indexPath.row].title
            
            return cell
        
        // 간단한 일기
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
            
        // 자세한 일기 조회
        case ..<viewModel.selectedDetailData.count:
            viewModel.selectedDate = viewModel.selectedDetailData[indexPath.row].date?.convertDate() ?? Date()
            
            let vc = ReadVC()
            vc.parentVC = self
            vc.selectedIndex = indexPath.row
            
            navigationController?.pushViewController(vc, animated: true)
            
        // 간단한 일기 조회
        case viewModel.selectedDetailData.count...:
            let vc = SimpleWriteVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.parentVC = self
            vc.selectedIndex = indexPath.row - viewModel.selectedDetailData.count
            vc.delegate = self
            vc.updateFlag = true
            
            present(vc, animated: true)
            
        default:
            break
        }
    }
}

// MARK: - Custom Protocol

extension MainVC: reloadDelegate {
    func reloadData() {
        getAllData()
    }
}
