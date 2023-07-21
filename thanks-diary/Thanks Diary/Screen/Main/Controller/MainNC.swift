//
//  MainNC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/21.
//

import UIKit

class MainNC: BaseNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([MainVC()], animated: true)
    }
}
