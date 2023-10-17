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
    private let viewModel = MainViewModel()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
        changeCalendarCircleDataAndTodayLabelText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.readData()
    }
    
    // MARK: - Function
    
    private func changeCalendarCircleDataAndTodayLabelText() {
        changeCalenderCircleDatasAndReloadCalendar()
        changeSetTodayLabelText()
    }
    
    private func changeCalenderCircleDatasAndReloadCalendar() {
        Observable.combineLatest(viewModel.allDetailDataRx, viewModel.allSimpleDataRx)
            .subscribe(onNext: { [weak self] detailDatas, simpleDatas in
                guard let self else { return }
                let detailData = detailDatas.map({ $0.key })
                let simpleData = simpleDatas.map({ $0.key })
                self.viewModel.diaryDates = Set(detailData).union(simpleData)
                self.mainView.calendar.reloadData()
            })
            .disposed(by: disposeBag)

    }

    private func changeSetTodayLabelText() {
        viewModel.selectedDate
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.mainView.setTodayLabelText(date: $0)
            })
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
        return CGPoint(x: 0, y: -6)
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}

// MARK: - initalize

extension MainVC {
    private func initalize() {
        initDelegate()
        initTable()
        initTarget()
    }
    
    private func initDelegate() {
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
    }
    
    private func initTarget() {
        initFloattingButtonTarget()
        initSettingButtonTarget()
        initTodayButtonTarget()
    }
    
    private func initFloattingButtonTarget() {
        mainView.floatingButton.button.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                pushFloatingButtonVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initSettingButtonTarget() {
        mainView.settingButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                pushSettingVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initTodayButtonTarget() {
        mainView.todayButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                moveToday()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - TableView

extension MainVC {
    private func initTable() {
        mainView.diaryTableView.delegate = nil
        mainView.diaryTableView.dataSource = nil
        
        settingTableViewEmptyImageOrData()
        initTableViewCellForRow()
        initTableViewDidSelected()
    }
    
    private func settingTableViewEmptyImageOrData() {
        viewModel.selectedAllData
            .subscribe(onNext: { [weak self] allData in
                guard let self else { return }
                if allData.isEmpty {
                    mainView.setHiddenForEmptyView(isHidden: false)
                    
                    let date = self.viewModel.selectedDate.value
                    let view = date.convertString() == Date().convertString() ? NotTodayView() : NotBeforeView()
                    mainView.setEmptyView(view: view)
                } else {
                    mainView.setHiddenForEmptyView(isHidden: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func initTableViewCellForRow() {
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
    }
    
    private func initTableViewDidSelected() {
        Observable.zip(mainView.diaryTableView.rx.modelSelected(DiaryModel.self), mainView.diaryTableView.rx.itemSelected)
            .bind { [weak self] diary, _ in
                guard let self else { return }
                if diary.type == .detail {
                    pushDetailWriteVC(beforeData: diary)
                } else {
                    presentSimpleWriteVC(beforeData: diary)
                }
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - View Change

extension MainVC {
    private func pushFloatingButtonVC() {
        let vc = FloatingButtonVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        vc.floatingButtonCloseView.detailButton.button.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                dismissVC {
                    self.pushDetailWriteVC(beforeData: nil)
                }
            })
            .disposed(by: disposeBag)
        
        vc.floatingButtonCloseView.simpleButton.button.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                dismissVC {
                    self.presentSimpleWriteVC(beforeData: nil)
                }
            })
            .disposed(by: disposeBag)
        
        present(vc, animated: false)
    }
    
    private func pushDetailWriteVC(beforeData: DiaryModel?) {
        let vc = DetailWriteVC()
        vc.viewModel = viewModel
        vc.beforeData = beforeData
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentSimpleWriteVC(beforeData: DiaryModel?) {
        let vc = SimpleWriteVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.viewModel = viewModel
        vc.beforeData = beforeData
        present(vc, animated: true)
    }
    
    private func pushSettingVC() {
        let vc = SettingVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
