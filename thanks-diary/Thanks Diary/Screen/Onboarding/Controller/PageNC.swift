//
//  PageNC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/21.
//

import UIKit

class PageNC: BaseNavigationController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([PageVC()], animated: true)
    }
}
