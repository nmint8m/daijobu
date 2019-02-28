//
//  NaviPushAlongsideTransitionCompletionVC.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 10/27/18.
//  Copyright © 2018 Tam Nguyen M. All rights reserved.
//

import UIKit

final class NaviPushAlongsideTransitionCompletionVC: UIViewController {

    let labelHeight: CGFloat = 70
    let screenWidth: CGFloat = UIScreen.main.bounds.width

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Navigation Push Along Side Transition"
    }

    @IBAction private func pushBtnTouchInside() {
        let transitionLabel = UILabel(frame: CGRect(x: 0, y: (screenWidth - labelHeight) / 2,
                                                    width: screenWidth, height: labelHeight))
        transitionLabel.text = "Transitioning..."
        transitionLabel.backgroundColor = .magenta

        let vc = NaviPushAlongsideTransitionCompletionVC()
        navigationController?
            .pushViewControllerAlongsideTransision(vc,
                                                   animated: true,
                                                   alongsideTransition: { [weak self] in
                    guard let this = self else { return }
                    this.navigationController?.view.addSubview(transitionLabel)
                }, completion: {
                    transitionLabel.removeFromSuperview()
            })
    }

    @IBAction private func dismissBtnTouchInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
