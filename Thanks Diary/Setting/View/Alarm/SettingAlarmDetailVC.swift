//
//  SettingAlarmDetailVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import UIKit

class SettingAlarmDetailVC: UIViewController {

    @IBOutlet weak var timeDatePicker: UIDatePicker!
    var selectedTime: Date = Date()
    weak var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeDatePicker.date = self.selectedTime
        let loc = Locale(identifier: "ko_KR")
        self.timeDatePicker.locale = loc
    }
    
    @IBAction func selectTime(_ sender: Any) {
        self.selectedTime = timeDatePicker.date
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func enter(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate?.sendData(self.selectedTime)
        })
    }
}

protocol SendDataDelegate: AnyObject {
    func sendData (_ date: Date)
}
