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
    @IBOutlet weak var oneBtn: UIButton!
    @IBOutlet weak var twoBtn: UIButton!
    @IBOutlet weak var threeBtn: UIButton!
    @IBOutlet weak var fourBtn: UIButton!
    @IBOutlet weak var fiveBtn: UIButton!
    @IBOutlet weak var sixBtn: UIButton!
    @IBOutlet weak var sevenBtn: UIButton!
    @IBOutlet weak var eightBtn: UIButton!
    @IBOutlet weak var nineBtn: UIButton!
    @IBOutlet weak var zeroBtn: UIButton!
    
    var count: Int = 0
    var reEnterFlag: Bool = false
    var homeFlag: Bool = false
    var firstPW: String = ""
    var secondPW: String = ""
    var coincidePW: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if homeFlag == true {
            message.text = "비밀번호를 입력해주세요"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func touchNumberBtn(_ sender: UIButton) {
        if sender == self.oneBtn {
            firstPW.append(contentsOf: "1")
        } else if sender == self.twoBtn {
            firstPW.append(contentsOf: "2")
        } else if sender == self.threeBtn {
            firstPW.append(contentsOf: "3")
        } else if sender == self.fourBtn {
            firstPW.append(contentsOf: "4")
        } else if sender == self.fiveBtn {
            firstPW.append(contentsOf: "5")
        } else if sender == self.sixBtn {
            firstPW.append(contentsOf: "6")
        } else if sender == self.sevenBtn {
            firstPW.append(contentsOf: "7")
        } else if sender == self.eightBtn {
            firstPW.append(contentsOf: "8")
        } else if sender == self.nineBtn {
            firstPW.append(contentsOf: "9")
        } else if sender == self.zeroBtn {
            firstPW.append(contentsOf: "0")
        }
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
            if homeFlag == true && firstPW == LocalDataStore.localDataStore.getPasswordNumber() {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else if homeFlag == true && firstPW != LocalDataStore.localDataStore.getPasswordNumber() {
                firstImg.image =
                    UIImage(named: "ic_gray_dot_12")
                secondImg.image =
                    UIImage(named: "ic_gray_dot_12")
                thirdImg.image =
                    UIImage(named: "ic_gray_dot_12")
                fourthImg.image =
                    UIImage(named: "ic_gray_dot_12")
                message.text = "비밀번호가 일치하지 않습니다"
                message.textColor = UIColor(named: "redColor")!
                firstPW = ""
                secondPW = ""
                reEnterFlag = false
                count = 0
            } else if homeFlag == false {
                if reEnterFlag == false {
                    firstImg.image =
                        UIImage(named: "ic_gray_dot_12")
                    secondImg.image =
                        UIImage(named: "ic_gray_dot_12")
                    thirdImg.image =
                        UIImage(named: "ic_gray_dot_12")
                    fourthImg.image =
                        UIImage(named: "ic_gray_dot_12")
                    message.text = "비밀번호를 다시 한번 입력해 주세요"
                    message.textColor = UIColor(named: "grayColor_1")!
                    secondPW = firstPW
                    firstPW = ""
                    reEnterFlag = true
                    count = 0
                } else {
                    if firstPW == secondPW {
                        LocalDataStore.localDataStore.setPasswordNumber(newData: firstPW)
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        firstImg.image =
                            UIImage(named: "ic_gray_dot_12")
                        secondImg.image =
                            UIImage(named: "ic_gray_dot_12")
                        thirdImg.image =
                            UIImage(named: "ic_gray_dot_12")
                        fourthImg.image =
                            UIImage(named: "ic_gray_dot_12")
                        message.text = "비밀번호가 일치하지 않습니다"
                        message.textColor = UIColor(named: "redColor")!
                        firstPW = ""
                        secondPW = ""
                        reEnterFlag = false
                        count = 0
                    }
                }
            }
        default:
            break
        }
    }
    
    @IBAction func touchBackBtn(_ sender: Any) {
        count = count - 1
        firstPW.popLast()
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
