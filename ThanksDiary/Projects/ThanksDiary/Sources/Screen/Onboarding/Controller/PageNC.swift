//
//  PageNC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/21.
//

import UIKit

final class PageNC: BaseNavigationController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([PageVC()], animated: true)
    }
}
