//
//  DecreaseFontSizeOfLabelsVC.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 3/1/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class DecreaseFontSizeOfLabelsVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var atkLabel: UILabel!
    @IBOutlet private weak var hpLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var atkTextField: UITextField!
    @IBOutlet private weak var hpTextField: UITextField!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configDefaultStackView()
        configDefaultLabels()
    }

    // MARK: - Functions
    private func configDefaultStackView() {
        stackView.alignment = .fill
        stackView.distribution = .fill
    }

    private func configDefaultLabels() {
        configDefaultLabel(nameLabel, isHighPriority: false)
        configDefaultLabel(atkLabel, isHighPriority: true)
        configDefaultLabel(hpLabel, isHighPriority: true)
    }

    private func configDefaultLabel(_ label: UILabel, isHighPriority: Bool) {
        label.font = Config.defaultFont
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.setContentHuggingPriority(isHighPriority ? Config.highPrioryty : Config.lowPrioryty,
                                        for: .horizontal)
    }

    // MARK: - IBActions
    @IBAction func closeBtnTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func applyBtnTouchUpInside(_ sender: Any) {
        let name: String = nameTextField.text ?? Config.defaultName
        let atk: String = atkTextField.text ?? Config.defaultATK
        let hp: String = hpTextField.text ?? Config.defaultHP

        nameLabel.text = name
        atkLabel.text = atk
        hpLabel.text = hp

        let expectedWidth = name.contentWidth(font: Config.defaultFont) +
            atk.contentWidth(font: Config.defaultFont) +
            hp.contentWidth(font: Config.defaultFont) +
            Config.stackViewSpacing * 2

        stackView.distribution = expectedWidth > stackView.bounds.width ? .fillProportionally : .fill
    }
}

extension DecreaseFontSizeOfLabelsVC {
    struct Config {
        static let minimumFontScale: CGFloat = 0.5
        static let maximumFontScale: CGFloat = 1
        static let highPrioryty = UILayoutPriority(252)
        static let lowPrioryty = UILayoutPriority(250)
        static let defaultName = "Name"
        static let defaultATK = "ATK"
        static let defaultHP = "HP"
        static let defaultFont = UIFont.systemFont(ofSize: 15)
        static let stackViewSpacing: CGFloat = 10
    }
}
