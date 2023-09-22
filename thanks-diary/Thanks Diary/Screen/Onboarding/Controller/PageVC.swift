//
//  PageVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit

final class PageVC: BaseVC {
    
    // MARK: - Property
    
    private let pageView = PageView()
    private var pageContainer: UIPageViewController!
    private var pageList = [UIViewController]()
    private var currentIndex: Int = 0 {
        didSet {
            changeDotViewColor()
            if currentIndex == pageList.count - 1 {
                UIView.transition(with: self.pageView.nextButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
                    self.pageView.nextButton.setTitle("text_start".localized, for: .normal)
                })
            } else {
                UIView.transition(with: self.pageView.nextButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
                    self.pageView.nextButton.setTitle("text_next".localized, for: .normal)
                })
            }
        }
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = pageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTarget()
        initPageVC()
    }

    private func initTarget() {
        pageView.nextButton.addTarget { _ in
            if self.currentIndex == self.pageList.count - 1 {
                UserDefaultManager.instance?.set(true, key: UserDefaultKey.IS_LOGIN.rawValue)
                self.registMainToRoot()
                return
            }
            self.moveNextPage()
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

    private func initPageVC() {

        pageList = [FirstStartVC(), SecondStartVC(), ThirdStartVC()]

        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageContainer.delegate = self
        if let firstVC = pageList.first {
            pageContainer.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        pageContainer.view.frame = pageView.containerView.bounds
        pageView.containerView.addSubview(pageContainer.view)
        pageContainer.view.setAutoLayout(to: pageView.containerView)
    }

    private func moveNextPage() {
        if currentIndex < pageList.count - 1 {
            currentIndex += 1
        }
        pageContainer.setViewControllers([pageList[currentIndex]], direction: .forward, animated: true, completion: nil)
    }
}

extension PageVC: UIPageViewControllerDelegate {
    // 페이지 이동할때 마다 호출
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        currentIndex = pageViewController.viewControllers!.first!.view.tag
    }
}
