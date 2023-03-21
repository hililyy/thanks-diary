//
//  MainTableView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/22.
//

import UIKit

class MainTableView: NSObject {
    var mainVC: MainVC
    let mainModel = MainModel.model
    
    init(_ mainVC: MainVC) {
        self.mainVC = mainVC
    }
}

extension MainTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mainModel = MainModel.model
           
        if mainModel.loginType == LoginType.none {
            if mainModel.longData.count == 0 && mainModel.shortData.count == 0 {
                if  mainModel.selectedDate.convertString() == Date().convertString() {
                    mainVC.emptyView.isHidden = false
                    mainVC.emptyView.frame.size.height = 300
                    mainVC.emptyImage.image = UIImage(named: "img_not_today")
                    return 0
                } else {
                    mainVC.emptyView.isHidden = false
                    mainVC.emptyView.frame.size.height = 300
                    mainVC.emptyImage.image = UIImage(named: "img_not_before")
                    return 0
                }
            } else {
                mainVC.emptyView.isHidden = true
                mainVC.emptyView.frame.size.height = 0
                return mainModel.longData.count + mainModel.shortData.count
            }
        } else {
            if mainModel.longDiaryDatabyDate.count == 0 && mainModel.shortDiaryDatabyDate.count == 0 {
                if  mainModel.selectedDate.convertString() == Date().convertString() {
                    mainVC.emptyView.isHidden = false
                    mainVC.emptyView.frame.size.height = 300
                    mainVC.emptyImage.image = UIImage(named: "img_not_today")
                    return 0
                } else {
                    mainVC.emptyView.isHidden = false
                    mainVC.emptyView.frame.size.height = 300
                    mainVC.emptyImage.image = UIImage(named: "img_not_before")
                    return 0
                }
            } else {
                mainVC.emptyView.isHidden = true
                mainVC.emptyView.frame.size.height = 0
                return mainModel.longDiaryDatabyDate.count + mainModel.shortDiaryDatabyDate.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mainModel.loginType == LoginType.none {
            switch indexPath.row {
            case ..<mainModel.longData.count:
                let cell = mainVC.diaryTableView.dequeueReusableCell(withIdentifier: "DetailDiaryListCell", for: indexPath) as! DetailDiaryListCell
                cell.titleLabel.text = mainModel.longData[indexPath.row].title
                cell.selectionStyle = .none
                return cell
            case mainModel.longData.count...:
                let cell = mainVC.diaryTableView.dequeueReusableCell(withIdentifier: "SimpleDiaryListCell", for: indexPath) as! SimpleDiaryListCell
                cell.titleLabel.text =
                mainModel.shortData[indexPath.row - mainModel.longData.count].contents
                cell.selectionStyle = .none
                return cell
            default:
                break
            }
        } else {
            switch indexPath.row {
            case ..<mainModel.longDiaryDatabyDate.count:
                let cell = mainVC.diaryTableView.dequeueReusableCell(withIdentifier: "DetailDiaryListCell", for: indexPath) as! DetailDiaryListCell
                cell.titleLabel.text = mainModel.longDiaryDatabyDate[indexPath.row].title
                cell.selectionStyle = .none
                return cell
            case mainModel.longDiaryDatabyDate.count...:
                let cell = mainVC.diaryTableView.dequeueReusableCell(withIdentifier: "SimpleDiaryListCell", for: indexPath) as! SimpleDiaryListCell
                cell.titleLabel.text =
                mainModel.shortDiaryDatabyDate[indexPath.row - mainModel.longDiaryDatabyDate.count].contents
                cell.selectionStyle = .none
                return cell
            default:
                break
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if mainModel.loginType == LoginType.none {
            switch indexPath.row {
            case ..<mainModel.longData.count:
                mainVC.showReadVC(index: indexPath.row)
            case mainModel.longData.count...:
                mainVC.showSimpleWriteVC(isEdit: true,selectedIndex: indexPath.row - mainModel.longData.count)
            default:
                break
            }
        } else {
            switch indexPath.row {
            case ..<mainModel.longDiaryDatabyDate.count:
                mainVC.showReadVC(index: indexPath.row)
            case mainModel.longDiaryDatabyDate.count...:
                mainVC.showSimpleWriteVC(isEdit: true,selectedIndex: indexPath.row - mainModel.longDiaryDatabyDate.count)
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
