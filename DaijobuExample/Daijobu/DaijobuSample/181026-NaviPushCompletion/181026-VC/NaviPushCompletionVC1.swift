//
//  NaviPushCompletionVC1.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 10/26/18.
//  Copyright © 2018 Tam Nguyen M. All rights reserved.
//

import UIKit

final class NaviPushCompletionVC1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Navigation Push Completion 1"
    }

    @IBAction private func pushBtnTouchInside() {
        navigationController?.pushViewControllerCompletion(NaviPushCompletionVC1(),
                                                           animated: true) { [weak self] in
                                                            self?.view.backgroundColor = .orange
        }
    }

    @IBAction private func presentBtnTouchInside(_ sender: Any) {
        present(NaviPushCompletionVC1(), animated: true) { [weak self] in
            self?.view.backgroundColor = .yellow
        }
    }

    @IBAction private func dismissBtnTouchInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
