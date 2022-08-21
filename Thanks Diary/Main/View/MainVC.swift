//
//  MainVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/18.
//

import UIKit
import FSCalendar
import Floaty

class MainVC: UIViewController {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var diaryTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    var tmpData: [String] = ["안뇽"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.diaryTableView.delegate = self
        self.diaryTableView.dataSource = self
        setFloty()
        setCalender()
    }
    
    func setFloty() {
        let floaty = Floaty()
        floaty.buttonColor = UIColor(named: "mainColor")!
        floaty.plusColor = UIColor(named: "whiteColor")!
        floaty.addItem("간단하게", icon: UIImage(named: "ic_simple_write")!)
        floaty.addItem("자세하게", icon: UIImage(named: "ic_detail_write")!, handler: { item in
            guard let vc =  self.storyboard?.instantiateViewController(identifier: "WriteVC") as? WriteVC else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            floaty.close()
        })

        self.view.addSubview(floaty)
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func goSetting(_ sender: Any) {
        guard let vc =  storyboard?.instantiateViewController(identifier: "SettingVC") as? SettingVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tmpData.count == 0 {
            emptyView.isHidden = false
            diaryTableView.isScrollEnabled = false
            return 0
        } else {
            emptyView.isHidden = true
            return tmpData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = diaryTableView.dequeueReusableCell(withIdentifier: "MainDiaryListCell", for: indexPath)
        return cell
    }
    
    
}
