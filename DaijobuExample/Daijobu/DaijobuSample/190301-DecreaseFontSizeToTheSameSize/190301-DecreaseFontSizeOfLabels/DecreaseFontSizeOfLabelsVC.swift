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
        configDefaultTextFields()
    }

    // MARK: - Functions
    private func configDefaultStackView() {
        stackView.alignment = .fill
        stackView.distribution = .fill
    }

    private func configDefaultLabels() {
        configDefaultLabel(nameLabel, huggingPriority: 250)
        configDefaultLabel(atkLabel, huggingPriority: 251)
        configDefaultLabel(hpLabel, huggingPriority: 252)
    }

    private func configDefaultLabel(_ label: UILabel, huggingPriority: Float) {
        label.font = Config.defaultFont
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.setContentHuggingPriority(UILayoutPriority(huggingPriority), for: .horizontal)
    }

    private func configDefaultTextFields() {
        nameTextField.delegate = self
        atkTextField.delegate = self
        hpTextField.delegate = self
    }

    // MARK: - IBActions
    @IBAction func closeBtnTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func applyBtnTouchUpInside(_ sender: Any) {
        var name: String = nameTextField.text ?? Config.defaultName
        name = name.trimmed.isEmpty ? Config.defaultName : name

        var atk: String = atkTextField.text ?? Config.defaultATK
        atk = atk.trimmed.isEmpty ? Config.defaultATK : atk

        var hp: String = hpTextField.text ?? Config.defaultHP
        hp = hp.trimmed.isEmpty ? Config.defaultHP : hp

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

// MARK: - Config
extension DecreaseFontSizeOfLabelsVC {
    struct Config {
        static let minimumFontScale: CGFloat = 0.5
        static let maximumFontScale: CGFloat = 1
        static let defaultName = "Name"
        static let defaultATK = "ATK"
        static let defaultHP = "HP"
        static let defaultFont = UIFont.systemFont(ofSize: 15)
        static let stackViewSpacing: CGFloat = 10
    }
}

// MARK: - UITextFieldDelegate
extension DecreaseFontSizeOfLabelsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
