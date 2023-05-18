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

    override func viewDidLoad() {
        super.viewDidLoad()
        setPageVC()
    }
    
    func setPageVC() {
        let storyBoard = UIStoryboard(name: "Start", bundle: nil)
        
        var page1: FirstStartVC? = storyBoard.instantiateViewController(withIdentifier: "FirstStartVC") as? FirstStartVC
        var page2: SecondStartVC? = storyBoard.instantiateViewController(withIdentifier: "SecondStartVC") as? SecondStartVC
        var page3: ThirdStartVC? = storyBoard.instantiateViewController(withIdentifier: "ThirdStartVC") as? ThirdStartVC
        
        guard let page1 = page1, let page2 = page2, let page3 = page3 else { return }
        
        page1.parentVC = self
        page2.parentVC = self
        page3.parentVC = self
        
        pageList = [page1, page2, page3]
        
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pageContainer.dataSource = self
        pageContainer.delegate = self
        
        if let firstVC = pageList.first {
            pageContainer.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
        pageContainer.view.frame = containerView.bounds
        containerView.addSubview(pageContainer.view)
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
    // 현재 페이지
    func pageViewController(_ pageViewController: UIPageViewController,didFinishAnimating finished: Bool,previousViewControllers: [UIViewController],transitionCompleted completed: Bool){
        guard completed else { return }
        currentIndex = pageViewController.viewControllers!.first!.view.tag
    }
    
    // 이전 페이지 이동
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageList.firstIndex(of: viewController) else {return nil}
        if index - 1 < 0 { return nil}
        
        return pageList[index - 1]
    }
    
    // 다음 페이지 이동
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageList.firstIndex(of: viewController) else {return nil}
        if currentIndex + 1 == pageList.count { return nil}
        
        return pageList[index + 1]
    }
}
