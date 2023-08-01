//
//  LoadingIndicator.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import UIKit

protocol LoadingFeature {
    func startLoading()
    func stopLoading()
}

class LoadingIndicator: LoadingFeature {

    private let indicatorView = UIActivityIndicatorView(style: .medium)
    func startLoading() {
        guard let viewController = UIApplication.shared.topViewController() else {
            print("🆘 fail to get top view")
            return
        }

        self.indicatorView.color = .gray
        self.indicatorView.startAnimating()
        self.indicatorView.center = viewController.view.center
        DispatchQueue.main.async {
            viewController.view.addSubview(self.indicatorView)
        }
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            self.indicatorView.removeFromSuperview()
        }
    }
}

extension UIApplication {

    func topViewController() -> UIViewController? {
        var topViewController: UIViewController?
        if #available(iOS 13, *) {
            for scene in connectedScenes {
                if let windowScene = scene as? UIWindowScene {
                    for window in windowScene.windows where window.isKeyWindow {
                        topViewController = window.rootViewController
                    }
                }
            }
        } else {
            topViewController = keyWindow?.rootViewController
        }
        while true {
            if let presented = topViewController?.presentedViewController {
                topViewController = presented
            } else if let navController = topViewController as? UINavigationController {
                topViewController = navController.topViewController
            } else if let tabBarController = topViewController as? UITabBarController {
                topViewController = tabBarController.selectedViewController
            } else {
                // Handle any other third party container in `else if` if required
                break
            }
        }
        return topViewController
    }
}
