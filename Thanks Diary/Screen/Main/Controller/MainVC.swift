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
        initTable()
        initTarget()
        changeCalenderCircleDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.readData()
    }
    
    // MARK: - Function
    
    private func changeCalenderCircleDatas() {
        Observable.combineLatest(viewModel.allDetailDataRx, viewModel.allSimpleDataRx)
            .subscribe(onNext: { [weak self] detailDatas, simpleDatas in
                guard let self else { return }
                let detailData = detailDatas.map({ $0.key })
                let simpleData = simpleDatas.map({ $0.key })
                self.viewModel.diaryDates = Set(detailData).union(simpleData)
                self.mainView.calendar.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.selectedDate
            .bind(onNext: { [weak self] in
                guard let self else { return }
                
                self.mainView.setTodayLabelText(date: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func initTarget() {
        mainView.floatingButton.button.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                self.pushFloatingButtonVC()
            })
            .disposed(by: disposeBag)
        
        mainView.settingButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                let vc = SettingVC()
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        mainView.todayButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                self.moveToday()
            })
            .disposed(by: disposeBag)
    }
    
    private func pushFloatingButtonVC() {
        let vc = FloatingButtonVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        vc.floatingButtonCloseView.detailButton.button.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                self.dismissVC {
                    self.pushDetailWriteVC()
                }
            })
            .disposed(by: disposeBag)
        
        vc.floatingButtonCloseView.simpleButton.button.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                self.dismissVC {
                    self.presentSimpleWriteVC()
                }
            })
            .disposed(by: disposeBag)
        
        self.present(vc, animated: false)
    }
    
    private func pushDetailWriteVC() {
        let vc = DetailWriteVC()
        vc.viewModel = self.viewModel
        vc.beforeData = nil
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentSimpleWriteVC() {
        let vc = SimpleWriteVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.viewModel = self.viewModel
        vc.beforeData = nil
        self.present(vc, animated: true)
    }
    
    private func initTable() {
        mainView.diaryTableView.delegate = nil
        mainView.diaryTableView.dataSource = nil
        
        viewModel.selectedAllData
            .subscribe(onNext: { [weak self] allData in
                guard let self else { return }
                
                if allData.isEmpty {
                    self.mainView.setHiddenForEmptyView(isHidden: false)
                    
                    let date = self.viewModel.selectedDate.value
                    let image = date.convertString() == Date().convertString() ? Asset.Image.imgNotToday.image : Asset.Image.imgNotBefore.image
                    self.mainView.setImageForEmptyView(image: image)
                } else {
                    self.mainView.setHiddenForEmptyView(isHidden: true)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.selectedAllData
            .bind(to: mainView.diaryTableView.rx.items) { tableView, _, element in
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
            .bind { [weak self] diary, _ in
                guard let self else { return }
                
                if diary.type == .detail {
                    let vc = DetailWriteVC()
                    vc.viewModel = self.viewModel
                    vc.beforeData = diary
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = SimpleWriteVC()
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    vc.viewModel = self.viewModel
                    vc.beforeData = diary
                    self.present(vc, animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func moveToday() {
        viewModel.selectedDate.accept(Date())
        mainView.calendar.select(Date())
    }
}

// MARK: - FSCalendar

extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.selectedDate.accept(date)
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return viewModel.diaryDates.contains(date.convertString()) ? Asset.Image.icCircle.image : nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: -5.15)
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}
