//
//  NaviPushCompletionVC2.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 10/26/18.
//  Copyright © 2018 Tam Nguyen M. All rights reserved.
//

import UIKit

final class NaviPushCompletionVC2: UIViewController {
    var completion: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        view.backgroundColor = .white
        title = "Navigation Push Completion 2"
    }

    @IBAction private func pushBtnTouchInside() {
        let vc = NaviPushCompletionVC2()
        vc.completion = { [weak self] in
            guard let this = self else { return }
            this.view.backgroundColor = .green
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction private func presentBtnTouchInside(_ sender: Any) {
        present(NaviPushCompletionVC2(), animated: true) { [weak self] in
            self?.view.backgroundColor = .blue
        }
    }

    @IBAction private func dismissBtnTouchInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension NaviPushCompletionVC2: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        completion?()
    }
}
