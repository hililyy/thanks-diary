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
            let title = currentIndex == pageList.count - 1 ? L10n.start : L10n.next
            UIView.transition(with: self.pageView.nextButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.pageView.nextButton.setTitle(title, for: .normal)
            })
            
        }
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = pageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTarget()
        initPageVC()
    }

    private func initTarget() {
        pageView.nextButton.addTarget { [weak self] _ in
            guard let self else { return }
            if self.currentIndex == self.pageList.count - 1 {
                UserDefaultManager.instance?.set(true, key: UserDefaultKey.IS_RE_ENTRY_USER.rawValue)
                registMainToRoot()
            } else {
                moveNextPage()
            }
        }
    }

    private func changeDotViewColor() {
        UIView.transition(with: self.pageView.firstDotView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.pageView.firstDotView.backgroundColor = self.currentIndex == 0 ? ResourceManager.instance?.getMainColor() : Asset.Color.gray3.color
            self.pageView.secondDotView.backgroundColor = self.currentIndex == 1 ? ResourceManager.instance?.getMainColor() : Asset.Color.gray3.color
            self.pageView.thirdDotView.backgroundColor = self.currentIndex == 2 ? ResourceManager.instance?.getMainColor() : Asset.Color.gray3.color
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
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        currentIndex = pageViewController.viewControllers!.first!.view.tag
    }
}
