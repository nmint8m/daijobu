//
//  DecreaseFontSizeOfButtonsVC.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 3/1/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class DecreaseFontSizeOfButtonsVC: UIViewController {

    @IBOutlet private weak var nameButton: UIButton!
    @IBOutlet private weak var atkButton: UIButton!
    @IBOutlet private weak var hpButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var atkTextField: UITextField!
    @IBOutlet private weak var hpTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func closeBtnTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
