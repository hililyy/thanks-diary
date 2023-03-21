//
//  AlertManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/20.
//

import UIKit

final class AlertManager {
    
    func setAlert(_ vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        vc.present(alert, animated: false, completion: nil)
    }
}
