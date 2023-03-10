//
//  EmailLogin.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/25.
//

import Foundation

extension LoginVC {
    func startEmailLogin() {
        guard let vc =  storyboard?.instantiateViewController(identifier: "EmailLoginVC") as? EmailLoginVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
