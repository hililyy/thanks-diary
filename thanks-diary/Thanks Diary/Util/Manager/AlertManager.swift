//
//  AlertManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/20.
//

import UIKit

final class AlertManager {
    
    static let shared = AlertManager()
    
    func setAlert(_ vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        vc.present(alert, animated: false, completion: nil)
    }
    
    func setAlert(_ vc: UIViewController, title: String, message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "확인", style: .default){ _ in
            completion()
        })
        vc.present(alert, animated: false, completion: nil)
    }
}
