//
//  ViewController.swift
//  PageViewController
//
//  Created by 奥江英隆 on 2024/05/20.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tagContainerStackView: UIStackView!
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    private let viewControllers: [UIViewController] = [
        UIStoryboard.number1Storyboard.instantiateInitialViewController()!,
        UIStoryboard.number2Storyboard.instantiateInitialViewController()!,
        UIStoryboard.number3Storyboard.instantiateInitialViewController()!,
        UIStoryboard.number4Storyboard.instantiateInitialViewController()!,
        UIStoryboard.number5Storyboard.instantiateInitialViewController()!
        
    ]
    
    private var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    private var disposeBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        // pageControl
        pageControl.numberOfPages = viewControllers.count
        
        // pageViewController
        pageViewController.delegate = self
        pageViewController.dataSource = self
        containerView.addSubview(pageViewController.view)
        pageViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        pageViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        pageViewController.setViewControllers([viewControllers.first!],
                                              direction: .forward,
                                              animated: false)
        
        // tagContainerStackView
        tagContainerStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        Tag.allCases.forEach {
            let customView = CustomView(tag: $0)
            customView.tagButtonPublisher.sink { [weak self] _ in
                guard let self else {
                    return
                }
                moveTag(index: customView.pageTag.rawValue)
                if currentPage < customView.pageTag.rawValue {
                    pageViewController.setViewControllers([viewControllers[customView.pageTag.rawValue]],
                                                          direction: .forward,
                                                          animated: true)
                } else if viewControllers.count - 1 > customView.pageTag.rawValue {
                    pageViewController.setViewControllers([viewControllers[customView.pageTag.rawValue]],
                                                          direction: .reverse,
                                                          animated: true)
                }
                currentPage = customView.pageTag.rawValue
            }.store(in: &disposeBag)
            tagContainerStackView.addArrangedSubview(customView)
        }
    }
    
    private func moveTag(index: Int) {
        let targetTag = tagContainerStackView.arrangedSubviews.compactMap {
            $0 as? CustomView
        }[index]
        
        let dx = targetTag.center.x - scrollView.center.x
        let maxmove = scrollView.contentSize.width - scrollView.bounds.width
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self else {
                return
            }
            scrollView.contentOffset = CGPoint(x: max(min(maxmove, dx), 0), y: 0)
        }
    }
}

extension ViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let viewController = pageViewController.viewControllers?.first,
           let index = viewControllers.firstIndex(of: viewController) {
            moveTag(index: index)
            currentPage = index
        }
    }
}

extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = viewControllers.firstIndex(of: viewController),
           viewControllers.count - 1 > index {
            return viewControllers[index + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = viewControllers.firstIndex(of: viewController),
           0 < index {
            return viewControllers[index - 1]
        } else {
            return nil
        }
    }
}

