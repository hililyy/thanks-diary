//
//  PageVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit

final class PageVC: BaseVC {
    
    private let pageView = PageView()
    private var pageContainer: UIPageViewController!
    private var pageList = [UIViewController]()
    private var currentIndex: Int = 0 {
        didSet {
            changeDotViewColor()
            if currentIndex == pageList.count - 1 {
                UIView.transition(with: self.pageView.nextButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
                    self.pageView.nextButton.setTitle("시작하기", for: .normal)
                })
            } else {
                UIView.transition(with: self.pageView.nextButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
                    self.pageView.nextButton.setTitle("다음", for: .normal)
                })
            }
        }
    }

    override func loadView() {
        view = pageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        setPageVC()
    }

    private func setTarget() {
        pageView.nextButton.addTarget { [weak self ] _ in
            guard let self = self else { return }
            if self.currentIndex == self.pageList.count - 1 {
                self.setRootVC(name: "Main", identifier: "MainVC")
                return
            }
            self.nextPage()
        }
    }

    private func changeDotViewColor() {
        UIView.transition(with: self.pageView.firstDotView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.pageView.firstDotView.backgroundColor = self.currentIndex == 0 ? Color.COLOR_LIGHTGRAYBLUE : Color.COLOR_GRAY3
        })

        UIView.transition(with: self.pageView.secondDotView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.pageView.secondDotView.backgroundColor = self.currentIndex == 1 ? Color.COLOR_LIGHTGRAYBLUE : Color.COLOR_GRAY3
        })

        UIView.transition(with: self.pageView.thirdDotView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.pageView.thirdDotView.backgroundColor = self.currentIndex == 2 ? Color.COLOR_LIGHTGRAYBLUE : Color.COLOR_GRAY3
        })
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

        pageContainer.view.frame = pageView.containerView.bounds
        pageView.containerView.addSubview(pageContainer.view)
        pageContainer.view.setAutoLayout(to: pageView.containerView)
    }

    private func nextPage() {
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