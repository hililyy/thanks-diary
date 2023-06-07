//
//  PageViewController.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit

final class PageVC: BaseVC {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var firstDotView: UIView!
    @IBOutlet weak var secondDotView: UIView!
    @IBOutlet weak var thirdDotView: UIView!
    
    private let pageView = PageView()
    var pageContainer: UIPageViewController!
    var pageList = [UIViewController]()
    var currentIndex: Int = 0 {
        didSet {
            changeDotViewColor()
            if currentIndex == pageList.count - 1 {
                nextButton.setTitle("시작하기", for: .normal)
            } else {
                nextButton.setTitle("다음", for: .normal)
            }
        }
    }

    override func loadView() {
        view = pageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTarget()
        setPageVC()
    }
    
    private func setUI() {
        changeDotViewColor()
        nextButton.layer.cornerRadius = 20
        
        for dot in [firstDotView, secondDotView, thirdDotView] {
            guard let dot = dot else { return }
            dot.layer.cornerRadius = dot.frame.size.width / 2
        }
    }
    
    func setTarget() {
        nextButton.addTarget { [weak self ] _ in
            guard let self = self else { return }
            if self.currentIndex == self.pageList.count - 1 {
                self.setRootVC(name: "Main", identifier: "MainVC")
                return
            }
            self.nextPage()
        }
    }
    
    func changeDotViewColor() {
        firstDotView.backgroundColor = currentIndex == 0 ? Color.COLOR_LIGHTGRAYBLUE : .lightGray
        secondDotView.backgroundColor = currentIndex == 1 ? Color.COLOR_LIGHTGRAYBLUE : .lightGray
        thirdDotView.backgroundColor = currentIndex == 2 ? Color.COLOR_LIGHTGRAYBLUE : .lightGray
    }
    
    private func setPageVC() {
        let storyBoard = UIStoryboard(name: "Start", bundle: nil)
        
        let page1: FirstStartVC? = storyBoard.instantiateViewController(withIdentifier: "FirstStartVC") as? FirstStartVC
        let page2: SecondStartVC? = storyBoard.instantiateViewController(withIdentifier: "SecondStartVC") as? SecondStartVC
        let page3: ThirdStartVC? = storyBoard.instantiateViewController(withIdentifier: "ThirdStartVC") as? ThirdStartVC
        
        guard let page1 = page1, let page2 = page2, let page3 = page3 else { return }
        
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
    
    // 페이지 이동할때 마다 호출
    func pageViewController(_ pageViewController: UIPageViewController,didFinishAnimating finished: Bool,previousViewControllers: [UIViewController],transitionCompleted completed: Bool){
        guard completed else { return }
        currentIndex = pageViewController.viewControllers!.first!.view.tag
    }
    
    // 페이지 왼쪽 스와이프
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageList.firstIndex(of: viewController),
              index - 1 >= 0
        else { return nil }
        
        return pageList[index - 1]
    }
    
    // 페이지 오른쪽 스와이프
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageList.firstIndex(of: viewController),
              index + 1 != pageList.count
        else { return nil }
        
        return pageList[index + 1]
    }
}
