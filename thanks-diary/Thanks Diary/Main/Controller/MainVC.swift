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
import Firebase

final class MainVC: UIViewController {
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var diaryTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var todayBtn: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    
    let mainModel = MainModel.model
    var mainTableView: MainTableView?
    var mainCalendar: MainCalendar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        if mainModel.loginType == LoginType.none {
            reloadData()
        } else {
            reloadFirebaseData()
        }
    }
    
    @IBAction func goSetting(_ sender: UIButton) {
        self.showSettingVC()
    }
    
    @IBAction func moveTodayFocus(_ sender: UIButton) {
        mainCalendar?.moveToday()
    }
    
    @IBAction func uploadData(_ sender: UIButton) {
        AlertManager.shared.setAlert(self, title: "알림", message: "백업되지 않은 데이터가 있으면 백업합니다.") {
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
        self.todayDate.text = mainModel.selectedDate.convertString(format: "dd'일' (E)")
        mainCalendar?.setFloty()
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
