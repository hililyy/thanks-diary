//
//  AlertManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/20.
//

import UIKit

final class AlertManager {
    
    static let shared = AlertManager()
    private init() { }
    
    func okAlert(_ vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "text_ok".localized, style: .default))
        vc.present(alert, animated: false, completion: nil)
    }
    
    func okAlert(_ vc: UIViewController, title: String, message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "text_ok".localized, style: .default){ _ in
            completion()
        })
        vc.present(alert, animated: false, completion: nil)
    }
    
    func okCancelAlert(_ vc: UIViewController, title: String, message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "text_calcel".localized, style: .default))
        alert.addAction(UIAlertAction(title: "text_ok".localized, style: .default){ _ in
            completion()
        })
        vc.present(alert, animated: false, completion: nil)
    }
}
