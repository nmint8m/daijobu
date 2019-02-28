//
//  NaviPushAlongsideTransitionNaviExt.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 10/27/18.
//  Copyright © 2018 Tam Nguyen M. All rights reserved.
//

import UIKit

extension UINavigationController {
    func pushViewControllerAlongsideTransision(_ viewController: UIViewController,
                                      animated: Bool,
                                      alongsideTransition: (() -> Void)?,
                                      completion: @escaping (() -> Void)) {
        pushViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            completion()
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            alongsideTransition?()
        }, completion: { _ in
            completion()
        })
    }

    func popViewControllerAlongsideTransision(_ viewController: UIViewController,
                                              animated: Bool,
                                              alongsideTransition: (() -> Void)?,
                                              completion: @escaping (() -> Void)) {
        popViewController(animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            completion()
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            alongsideTransition?()
        }, completion: { _ in
            completion()
        })
    }
}
