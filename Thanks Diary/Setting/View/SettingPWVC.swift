//
//  SettingPWVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/20.
//

import UIKit

class SettingPWVC: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var firstImg: UIImageView!
    @IBOutlet weak var secondImg: UIImageView!
    @IBOutlet weak var thirdImg: UIImageView!
    @IBOutlet weak var fourthImg: UIImageView!
    var count: Int = 0
    var flag: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func touchNumberBtn(_ sender: Any) {
        count = count + 1
        switch count {
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
            if flag == false {
                firstImg.image =
                    UIImage(named: "ic_gray_dot_12")
                secondImg.image =
                    UIImage(named: "ic_gray_dot_12")
                thirdImg.image =
                    UIImage(named: "ic_gray_dot_12")
                fourthImg.image =
                    UIImage(named: "ic_gray_dot_12")
                message.text = "비밀번호를 다시 한번 입력해 주세요"
                flag = true
                count = 0
            } else {
                self.navigationController?.popViewController(animated: true)
            }
            
        default:
            break
        }
    }
    
    @IBAction func touchBackBtn(_ sender: Any) {
        count = count - 1
        if count < 0 {
            count = 0
        }
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

        default:
            break
        }
    }
    
    @IBAction func touchEnterBtn(_ sender: Any) {
    }
}
