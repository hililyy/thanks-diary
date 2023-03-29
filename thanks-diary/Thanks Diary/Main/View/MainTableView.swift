//
//  MainTableView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/22.
//

import UIKit

final class MainTableView: NSObject {
    private var mainVC: MainVC
    private let mainModel = MainModel.model
    
    init(_ mainVC: MainVC) {
        self.mainVC = mainVC
    }
}

extension MainTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mainModel = MainModel.model
           
        if mainModel.loginType == LoginType.none {
            if mainModel.detailData.count == 0 && mainModel.simpleData.count == 0 {
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
                return mainModel.detailData.count + mainModel.simpleData.count
            }
        } else {
            if mainModel.detailDiaryDatabyDate.count == 0 && mainModel.simpleDiaryDatabyDate.count == 0 {
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
                return mainModel.detailDiaryDatabyDate.count + mainModel.simpleDiaryDatabyDate.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mainModel.loginType == LoginType.none {
            switch indexPath.row {
            case ..<mainModel.detailData.count:
                let cell = mainVC.diaryTableView.dequeueReusableCell(withIdentifier: "DetailDiaryListCell", for: indexPath) as! DetailDiaryListCell
                cell.titleLabel.text = mainModel.detailData[indexPath.row].title
                cell.selectionStyle = .none
                return cell
            case mainModel.detailData.count...:
                let cell = mainVC.diaryTableView.dequeueReusableCell(withIdentifier: "SimpleDiaryListCell", for: indexPath) as! SimpleDiaryListCell
                cell.titleLabel.text =
                mainModel.simpleData[indexPath.row - mainModel.detailData.count].contents
                cell.selectionStyle = .none
                return cell
            default:
                break
            }
        } else {
            switch indexPath.row {
            case ..<mainModel.detailDiaryDatabyDate.count:
                let cell = mainVC.diaryTableView.dequeueReusableCell(withIdentifier: "DetailDiaryListCell", for: indexPath) as! DetailDiaryListCell
                cell.titleLabel.text = mainModel.detailDiaryDatabyDate[indexPath.row].title
                cell.selectionStyle = .none
                return cell
            case mainModel.detailDiaryDatabyDate.count...:
                let cell = mainVC.diaryTableView.dequeueReusableCell(withIdentifier: "SimpleDiaryListCell", for: indexPath) as! SimpleDiaryListCell
                cell.titleLabel.text =
                mainModel.simpleDiaryDatabyDate[indexPath.row - mainModel.detailDiaryDatabyDate.count].contents
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
            case ..<mainModel.detailData.count:
                mainVC.showReadVC(index: indexPath.row)
            case mainModel.detailData.count...:
                mainVC.showSimpleWriteVC(isEdit: true,selectedIndex: indexPath.row - mainModel.detailData.count)
            default:
                break
            }
        } else {
            switch indexPath.row {
            case ..<mainModel.detailDiaryDatabyDate.count:
                mainVC.showReadVC(index: indexPath.row)
            case mainModel.detailDiaryDatabyDate.count...:
                mainVC.showSimpleWriteVC(isEdit: true,selectedIndex: indexPath.row - mainModel.detailDiaryDatabyDate.count)
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
