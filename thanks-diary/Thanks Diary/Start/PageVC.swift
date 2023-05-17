//
//  PageViewController.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit

class PageVC: BaseVC {
    
    @IBOutlet weak var containerView: UIView!
    
    var pageContainer: UIPageViewController!
    var currentIndex: Int = 0
    var pageList = [UIViewController]()
    
    var page1: FirstStartVC!
    var page2: SecondStartVC!
    var page3: ThirdStartVC!

    override func viewDidLoad() {
        super.viewDidLoad()
        setPageVC()
    }
    
    func setPageVC() {
        let storyBoard = UIStoryboard(name: "Start", bundle: nil)
        
        page1 = storyBoard.instantiateViewController(withIdentifier: "FirstStartVC") as? FirstStartVC
        page2 = storyBoard.instantiateViewController(withIdentifier: "SecondStartVC") as? SecondStartVC
        page3 = storyBoard.instantiateViewController(withIdentifier: "ThirdStartVC") as? ThirdStartVC
        
        page1.parentVC = self
        page2.parentVC = self
        page3.parentVC = self
        
        pageList.append(page1)
        pageList.append(page2)
        pageList.append(page3)
        
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pageContainer.dataSource = self
        pageContainer.delegate = self
        
        if let firstVC = pageList.first {
            pageContainer.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        pageContainer.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
        containerView.addSubview(pageContainer.view ?? UIView())
        pageContainer.view.setAutoLayout(to: containerView)
    }
    
    func nextPage() {
        if currentIndex < pageList.count - 1 {
            currentIndex += 1
        }
        pageContainer.setViewControllers([pageList[currentIndex]], direction: .forward, animated: true, completion: nil)
    }
}

extension PageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageList.firstIndex(of: viewController) else {return nil}
        if index - 1 < 0 { return nil}
        return pageList[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageList.firstIndex(of: viewController) else {return nil}
        if index + 1 == pageList.count { return nil}
        return pageList[index + 1]
    }
}
