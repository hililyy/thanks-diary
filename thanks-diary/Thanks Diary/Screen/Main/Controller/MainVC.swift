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
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
        setTable()
        setTarget()
        setObservable()
    }
    
    // MARK: - Function
    
    func setObservable() {
        
        // 모든 다이어리 데이터가 갱신 되었을 때 (선택한 날짜 [string] 갱신)
        Observable.combineLatest(viewModel.allDetailDataRx, viewModel.allSimpleDataRx)
            .subscribe(onNext: { [weak self] detailDatas, simpleDatas in
                guard let self = self else { return }
                let detailData = detailDatas.map({ $0.key })
                let simpleData = simpleDatas.map({ $0.key })
                self.viewModel.diaryDates = Set(detailData).union(simpleData)
                mainView.calendar.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.selectedDate
            .bind(onNext: {
                self.mainView.setTodayLabelText(date: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func setTarget() {
        // 플로팅 버튼 핸들러 설정
        mainView.floatingButtonTapHandler = {
            let vc = FloatingButtonVC()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            vc.detailHandler = {
                let vc = DetailWriteVC()
                vc.viewModel = self.viewModel
                self.viewModel.selectedDiaryData = nil
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            vc.simpleHandler = {
                let vc = SimpleWriteVC()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                vc.viewModel = self.viewModel
                self.viewModel.selectedDiaryData = nil
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
    
    private func setTable() {
        mainView.diaryTableView.delegate = nil
        mainView.diaryTableView.dataSource = nil
        
        viewModel.selectedAllData
            .subscribe(onNext: { allData in
                if allData.isEmpty {
                    let date = self.viewModel.selectedDate.value
                    self.mainView.setHiddenForEmptyView(isHidden: false)
                    
                    if date.convertString() == Date().convertString() {
                        self.mainView.setImageForEmptyView(image: Image.IMG_NOT_TODAY)
                    } else {
                        self.mainView.setImageForEmptyView(image: Image.IMG_NOT_BEFORE)
                    }
                } else {
                    self.mainView.setHiddenForEmptyView(isHidden: true)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.selectedAllData
            .bind(to: mainView.diaryTableView.rx.items) { tableView, index, element in
                let cellIdentifier = element.type == .detail ? DetailDiaryTVCell.id : SimpleDiaryTVCell.id
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
                
                if let detailCell = cell as? DetailDiaryTVCell {
                    detailCell.titleLabel.text = element.title
                } else if let simpleCell = cell as? SimpleDiaryTVCell {
                    simpleCell.titleLabel.text = element.contents
                }
                return cell
            }
            .disposed(by: disposeBag)
        
        
        Observable.zip(mainView.diaryTableView.rx.modelSelected(DiaryModel.self), mainView.diaryTableView.rx.itemSelected)
            .bind { [weak self] (diary, index) in
                guard let self = self else { return }
                
                if diary.type == .detail {
                    let vc = ReadVC()
                    vc.viewModel = self.viewModel
                    viewModel.selectedDiaryData = diary
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = SimpleWriteVC()
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    vc.viewModel = self.viewModel
                    viewModel.selectedDiaryData = diary
                    self.present(vc, animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    // 오늘 날짜로 이동
    private func moveToday() {
        viewModel.selectedDate.accept(Date())
        mainView.calendar.select(Date())
    }
}

// MARK: - FSCalendar

extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // 캘린더 날짜 선택시 동작
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.selectedDate.accept(date)
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
