//
//  MainVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit
import FSCalendar
import CoreData
import Firebase

final class MainVC: BaseVC {
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var diaryTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var todayBtn: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    
    let viewModel = MainViewModel()
    var mainTableView: MainTableView?
    var mainCalendar: MainCalendar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
        floatingConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        if viewModel.loginType == .none {
            reloadData()
        } else {
            reloadFirebaseData()
        }
    }
    
    @IBAction func goSetting(_ sender: UIButton) {
        pushVC(name: "Setting", identifier: "SettingVC")
    }
    
    @IBAction func moveTodayFocus(_ sender: UIButton) {
        mainCalendar?.moveToday()
    }
    
    @IBAction func uploadData(_ sender: UIButton) {
        AlertManager.shared.okCancelAlert(self, title: "알림", message: "백업되지 않은 데이터가 있으면 백업합니다.") {
            self.mainModel.uploadData()
            self.reloadFirebaseData()
        }
    }
    
    func initalize() {
        mainTableView = MainTableView(self)
        mainCalendar = MainCalendar(self)
        diaryTableView.delegate = mainTableView
        diaryTableView.dataSource = mainTableView
        calendar.delegate = mainCalendar
        calendar.dataSource = mainCalendar
        
        self.todayBtn.layer.cornerRadius = 10
        self.todayLabel.text = mainModel.selectedDate.convertString(format: "dd'일' (E)")
        mainCalendar?.setCalender()
        setuploadBtn()
    }
    
    func setuploadBtn() {
        if mainModel.loginType != LoginType.none {
            self.uploadBtn.isHidden = false
        } else {
            self.uploadBtn.isHidden = true
        }
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
            vc.floatingButtonCloseView.simpleButton.button.addTarget { [weak self] _ in
                guard let self = self else { return }
                self.dismiss(animated: true) {
                    let simpleVC = self.storyboard?.instantiateViewController(withIdentifier: "SimpleWriteVC") as! SimpleWriteVC
                    simpleVC.modalPresentationStyle = .overFullScreen
                    self.present(simpleVC, animated: true)
                }
            }
            vc.floatingButtonCloseView.detailButton.button.addTarget { [weak self] _ in
                guard let self = self else { return }
                
                self.dismiss(animated: true) {
                    self.pushVC(name: "Main", identifier: "DetailWriteVC")
                }
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
    
    func getDataReloadTableView(type: String) {
        switch type {
        case "coredata":
            mainModel.getData() {
                self.diaryTableView.reloadData()
            }
        case "firebase":
            mainModel.getFirebaseData {
                self.diaryTableView.reloadData()
            }
        case "databydate":
            mainModel.setDataByDate()
            self.diaryTableView.reloadData()
        default:
            break
        }
    }
}

extension MainVC: reloadDelegate, reloadFirebaseDelegate {
    func reloadData() {
        mainModel.getData() {
            self.calendar.reloadData()
            self.diaryTableView.reloadData()
        }
    }
    
    func reloadFirebaseData() {
        mainModel.getFirebaseData {
            self.getDataReloadTableView(type: "databydate")
            self.calendar.reloadData()
            self.diaryTableView.reloadData()
        }
    }
}
