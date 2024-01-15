//
//  MainNC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/21.
//

import UIKit

final class MainNC: BaseNavigationController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainViewModel = MainViewModel()
        setViewControllers([MainVC(viewModel: mainViewModel)], animated: true)
    }
}
