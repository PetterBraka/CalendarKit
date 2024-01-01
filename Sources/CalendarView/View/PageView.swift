//
//  PageView.swift
//
//
//  Created by Petter vang Brakalsvålet on 31/12/2023.
//

import SwiftUI

public struct PageView<Page: View>: UIViewControllerRepresentable {
    private let pages: [UIViewController]
    private let initialIndex: Int
    private let transition: PageTransition
    
    public init(
        initialIndex: Int,
        pages: [Page],
        transition: PageTransition = .pageCurl
    ) {
        self.initialIndex = initialIndex
        self.pages = pages.map { UIHostingController(rootView: $0) }
        self.transition = transition
    }
    
    public func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .init(from: transition),
            navigationOrientation: .horizontal
        )
        pageViewController.dataSource = context.coordinator
        setInitialPage(of: pageViewController)
        return pageViewController
    }
    
    public func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {}
    
    private func setInitialPage(of pageViewController: UIPageViewController) {
        var initialPage: UIViewController? = nil
        if pages.count > initialIndex {
            initialPage = pages[initialIndex]
            
        } else if let lastPage = pages.last {
            initialPage = lastPage
        }
        if let initialPage {
            pageViewController.setViewControllers(
                [initialPage],
                direction: .forward,
                animated: false,
                completion: nil
            )
        }
    }
}
 
extension PageView {
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public final class Coordinator: NSObject, UIPageViewControllerDataSource {
        var parent: PageView
        
        init(_ pageView: PageView) {
            parent = pageView
        }
        
        public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            let pages = parent.pages
            guard let index = pages.firstIndex(of: viewController), index > 0
            else { return nil }
            return parent.pages[index - 1]
        }
        
        public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            let pages = parent.pages
            guard let index = pages.firstIndex(of: viewController),
                    index < pages.count - 1
            else { return nil }
            return parent.pages[index + 1]
        }
    }
}
