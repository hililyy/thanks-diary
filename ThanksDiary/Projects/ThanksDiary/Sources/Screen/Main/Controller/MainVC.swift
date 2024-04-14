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

final class MainVC: BaseVC<MainView> {
    
    // MARK: - Property
    
    private let viewModel: MainViewModel
    
    // MARK: - Init
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalize()
        changeCalendarCircleDataAndTodayLabelText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        attachedView.calendar.select(viewModel.selectedDate.value)
        viewModel.readData()
        presentAppReviewPopup()
    }
    
    // MARK: - Function
    
    private func changeCalendarCircleDataAndTodayLabelText() {
        changeCalenderCircleDatasAndReloadCalendar()
        changeSetTodayLabelText()
    }
    
    private func changeCalenderCircleDatasAndReloadCalendar() {
        Observable.combineLatest(viewModel.allDetailDataRx,
                                 viewModel.allSimpleDataRx)
        .subscribe(onNext: { [weak self] detailDatas, simpleDatas in
            guard let self else { return }
            
            let detailData = detailDatas.map({ $0.key })
            let simpleData = simpleDatas.map({ $0.key })
            
            viewModel.diaryDates = Set(detailData).union(simpleData)
            attachedView.calendar.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
    private func changeSetTodayLabelText() {
        viewModel.selectedDate
            .bind(onNext: { [weak self] in
                guard let self else { return }
                
                attachedView.setTodayLabelText(date: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func moveToday() {
        viewModel.selectedDate.accept(Date())
        attachedView.calendar.select(Date())
    }
    
    private func presentAppReviewPopup() {
        let diaryCount = viewModel.allDetailDataRx.value.count + viewModel.allSimpleDataRx.value.count
        let isPresentReviewPopup = UserDefaultManager.instance.isPresentReviewPopup
        
        if diaryCount >= 5 && !isPresentReviewPopup {
            UserDefaultManager.instance.isPresentReviewPopup = true
            CommonUtilManager.instance.presentAppReviewPopup()
        }
    }
}

// MARK: - FSCalendar

extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.selectedDate.accept(date)
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return viewModel.diaryDates.contains(date.toString(didChangeDateFormat: DateFormat.YYYYMD.rawValue)) ? Asset.Image.icCircle.image : nil
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
        initObservable()
    }
    
    private func initView() {
        attachedView.diaryTableView.reloadData()
        attachedView.calendar.reloadData()
        attachedView.initAllFont()
        attachedView.initAllColor()
    }
    
    private func initDelegate() {
        attachedView.calendar.delegate = self
        attachedView.calendar.dataSource = self
    }
    
    private func initTarget() {
        initTodayButtonTarget()
        initSearchButtonTarget()
        initSettingButtonTarget()
        initFloattingButtonTarget()
    }
    
    private func initTodayButtonTarget() {
        attachedView.todayButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                moveToday()
            })
            .disposed(by: disposeBag)
    }
    
    private func initSearchButtonTarget() {
        attachedView.searchButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                pushSearchVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initSettingButtonTarget() {
        attachedView.settingButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                pushSettingVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initFloattingButtonTarget() {
        attachedView.floatingButton.button.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                pushFloatingButtonVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func initObservable() {
        CommonUtilManager.instance.themeSubject.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            
            initView()
            changeCalendarCircleDataAndTodayLabelText()
        })
        .disposed(by: disposeBag)
    }
}

// MARK: - TableView

extension MainVC {
    private func initTable() {
        attachedView.diaryTableView.delegate = nil
        attachedView.diaryTableView.dataSource = nil
        
        settingTableViewEmptyImageOrData()
        initTableViewCellForRow()
        initTableViewDidSelected()
        initTableWillDisplay()
    }
    
    private func settingTableViewEmptyImageOrData() {
        viewModel.selectedAllData
            .subscribe(onNext: { [weak self] allData in
                guard let self else { return }
                
                if allData.isEmpty {
                    attachedView.setHiddenForEmptyView(isHidden: false)
                    
                    let date = self.viewModel.selectedDate.value
                    let view = date.toString(didChangeDateFormat: DateFormat.YYYYMD.rawValue) == Date().toString(didChangeDateFormat: DateFormat.YYYYMD.rawValue) ? NotTodayView() : NotBeforeView()
                    
                    attachedView.setEmptyView(view: view)
                } else {
                    attachedView.setHiddenForEmptyView(isHidden: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func initTableViewCellForRow() {
        viewModel.selectedAllData
            .bind(to: attachedView.diaryTableView.rx.items) { tableView, _, element in
                let cellIdentifier = element.type == .detail ? DetailDiaryTVCell.id : SimpleDiaryTVCell.id
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
                
                if let detailCell = cell as? DetailDiaryTVCell {
                    detailCell.titleLabel.text = element.title
                    detailCell.borderView.layer.borderColor = ResourceManager.instance.getMainColor().cgColor
                    detailCell.titleLabel.font = ResourceManager.instance.getFont(size: 17)
                    
                } else if let simpleCell = cell as? SimpleDiaryTVCell {
                    simpleCell.titleLabel.text = element.contents
                    simpleCell.dotView.backgroundColor = ResourceManager.instance.getMainColor()
                    simpleCell.titleLabel.font = ResourceManager.instance.getFont(size: 17)
                }
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func initTableViewDidSelected() {
        Observable.zip(attachedView.diaryTableView.rx.modelSelected(DiaryEntity.self),
                       attachedView.diaryTableView.rx.itemSelected)
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
    
    private func initTableWillDisplay() {
        attachedView.diaryTableView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] cell, indexPath in
                guard let self else { return }
                
                AnimationManager.animationMoveUpWithFadeIn(cell: cell, indexPath: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - View Change

extension MainVC {
    private func pushSearchVC() {
        let vc = SearchVC(viewModel: self.viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushSettingVC() {
        let vc = SettingVC(viewModel: SettingViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushFloatingButtonVC() {
        let vc = FloatingButtonOpendVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        vc.attachedView.detailButton.button.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self else { return }
                
                dismissVC {
                    self.pushDetailWriteVC(beforeData: nil)
                }
            })
            .disposed(by: disposeBag)
        
        vc.attachedView.simpleButton.button.rx.tap
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
    
    private func pushDetailWriteVC(beforeData: DiaryEntity?) {
        let vc = DetailWriteVC(viewModel: self.viewModel)
        vc.beforeData = beforeData
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentSimpleWriteVC(beforeData: DiaryEntity?) {
        let vc = SimpleWriteVC(viewModel: self.viewModel)
        vc.beforeData = beforeData
        present(vc, animated: true)
    }
}
