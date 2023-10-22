//
//  PageVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/17.
//

import UIKit

final class PageVC: BaseVC<PageView> {
    
    // MARK: - Property
    
    private var pageContainer: UIPageViewController!
    private var pageList = [UIViewController]()
    private var currentIndex: Int = 0 {
        didSet {
            changeDotViewColor()
            let title = currentIndex == pageList.count - 1 ? L10n.start : L10n.next
            UIView.transition(with: self.attachedView.nextButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.attachedView.nextButton.setTitle(title, for: .normal)
            })
            
        }
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = attachedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTarget()
        initPageVC()
    }

    private func initTarget() {
        attachedView.nextButton.addTarget { [weak self] _ in
            guard let self else { return }
            if self.currentIndex == self.pageList.count - 1 {
                UserDefaultManager.instance.isReEntryUser = true
                registMainToRoot()
            } else {
                moveNextPage()
            }
        }
    }

    private func changeDotViewColor() {
        UIView.transition(with: self.attachedView.firstDotView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.attachedView.firstDotView.backgroundColor = self.currentIndex == 0 ? ResourceManager.instance?.getMainColor() : Asset.Color.gray3.color
            self.attachedView.secondDotView.backgroundColor = self.currentIndex == 1 ? ResourceManager.instance?.getMainColor() : Asset.Color.gray3.color
            self.attachedView.thirdDotView.backgroundColor = self.currentIndex == 2 ? ResourceManager.instance?.getMainColor() : Asset.Color.gray3.color
        })
    }

    private func initPageVC() {
        pageList = [FirstStartVC(), SecondStartVC(), ThirdStartVC()]

        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageContainer.delegate = self
        if let firstVC = pageList.first {
            pageContainer.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        pageContainer.view.frame = attachedView.containerView.bounds
        attachedView.containerView.addSubview(pageContainer.view)
        pageContainer.view.setAutoLayout(to: attachedView.containerView)
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
