//
//  UINavigationControllerExt.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 10/26/18.
//  Copyright © 2018 Tam Nguyen M. All rights reserved.
//

import UIKit

extension UINavigationController {

    func pushViewControllerCompletion(_ viewController: UIViewController,
                            animated: Bool,
                            completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
