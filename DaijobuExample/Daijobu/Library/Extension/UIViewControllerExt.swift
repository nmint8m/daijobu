//
//  UIViewControllerExt.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 10/26/18.
//  Copyright © 2018 Tam Nguyen M. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentInformationAlert() {
        let alertController = UIAlertController(title: "More information",
                                                message: "Please go to\nhttps://github.com/nmint8m/daijobu\nfor more interesting example.",
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let url = URL(string: "https://github.com/nmint8m/daijobu") else { return }
            UIApplication.shared.openURL(url)
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}
