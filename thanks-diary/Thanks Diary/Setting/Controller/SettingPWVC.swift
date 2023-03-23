//
//  SettingPWVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/20.
//

import UIKit

final class SettingPWVC: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var firstImg: UIImageView!
    @IBOutlet weak var secondImg: UIImageView!
    @IBOutlet weak var thirdImg: UIImageView!
    @IBOutlet weak var fourthImg: UIImageView!
    
    private var count: Int = 0
    private var reEnterFlag: Bool = false
    var homeFlag: Bool = false
    private var firstPW: String = ""
    private var secondPW: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func touchNumberBtn(_ sender: UIButton) {
        firstPW.append(String(sender.tag))
        count += 1
        setImageByCount()
        if count == 4 {
            if homeFlag == true {
                if comparePW(LocalDataStore.localDataStore.getPasswordNumber(), firstPW) {
                    showMainVC()
                } else {
                    notMatch()
                }
            } else {
                if reEnterFlag == false {
                    reInput()
                } else {
                    if comparePW(firstPW, secondPW) {
                        LocalDataStore.localDataStore.setPasswordNumber(newData: firstPW)
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        notMatch()
                    }
                }
            }
        }
    }
    
    @IBAction func touchBackBtn(_ sender: Any) {
        count = count - 1
        if count < 0 {
            count = 0
        }
        setImageByCount()
    }
    
    func notMatch() {
        message.text = "비밀번호가 일치하지 않습니다"
        message.textColor = UIColor(named: "redColor")!
        firstPW = ""
        secondPW = ""
        reEnterFlag = false
        count = 0
    }
    
    func reInput() {
        message.text = "비밀번호를 다시 한번 입력해 주세요"
        message.textColor = UIColor(named: "grayColor_1")!
        secondPW = firstPW
        firstPW = ""
        reEnterFlag = true
        count = 0
    }
    
    func comparePW(_ first: String, _ second: String) -> Bool {
        return first == second
    }
    
    func setImageByCount() {
        switch count {
        case 0:
            count = 0
            firstImg.image =
            UIImage(named: "ic_gray_dot_12")
            secondImg.image =
            UIImage(named: "ic_gray_dot_12")
            thirdImg.image =
            UIImage(named: "ic_gray_dot_12")
            fourthImg.image =
            UIImage(named: "ic_gray_dot_12")
        case 1:
            firstImg.image =
            UIImage(named: "ic_blue_dot_12")
            secondImg.image =
            UIImage(named: "ic_gray_dot_12")
            thirdImg.image =
            UIImage(named: "ic_gray_dot_12")
            fourthImg.image =
            UIImage(named: "ic_gray_dot_12")
        case 2:
            firstImg.image =
            UIImage(named: "ic_blue_dot_12")
            secondImg.image =
            UIImage(named: "ic_blue_dot_12")
            thirdImg.image =
            UIImage(named: "ic_gray_dot_12")
            fourthImg.image =
            UIImage(named: "ic_gray_dot_12")
        case 3:
            firstImg.image =
            UIImage(named: "ic_blue_dot_12")
            secondImg.image =
            UIImage(named: "ic_blue_dot_12")
            thirdImg.image =
            UIImage(named: "ic_blue_dot_12")
            fourthImg.image =
            UIImage(named: "ic_gray_dot_12")
        case 4:
            firstImg.image =
            UIImage(named: "ic_gray_dot_12")
            secondImg.image =
            UIImage(named: "ic_gray_dot_12")
            thirdImg.image =
            UIImage(named: "ic_gray_dot_12")
            fourthImg.image =
            UIImage(named: "ic_gray_dot_12")
        default:
            break
        }
    }
}
