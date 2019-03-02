//
//  DecreaseFontSizeOfButtonsVC.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 3/1/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class DecreaseFontSizeOfButtonsVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var buttonsContainerView: UIView!
    @IBOutlet private weak var nameButton: UIButton!
    @IBOutlet private weak var atkButton: UIButton!
    @IBOutlet private weak var hpButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var atkTextField: UITextField!
    @IBOutlet private weak var hpTextField: UITextField!

    // MARK: - Property
    private var name = ""
    private var atk = ""
    private var hp = ""

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configDefaultButtons()
        configTDefaultTextFields()
    }

    // MARK: - Functions
    private func configDefaultButtons() {
        configDefaultButton(nameButton, compressionPriority: 750)
        configDefaultButton(atkButton, compressionPriority: 751)
        configDefaultButton(hpButton, compressionPriority: 752)
    }

    private func configDefaultButton(_ button: UIButton, compressionPriority: Float) {
        // Set up label
        let priority = UILayoutPriority(rawValue: compressionPriority)
        button.setContentCompressionResistancePriority(priority, for: .horizontal)
        button.setTitleColor(.black, for: .normal)

        // Set up title label
        button.titleLabel?.font = Config.defaultFont
        button.titleLabel?.lineBreakMode = .byTruncatingTail
    }

    private func configTDefaultTextFields() {
        nameTextField.delegate = self
        atkTextField.delegate = self
        hpTextField.delegate = self
    }

    private func updateButtonsTitleAndFont() {
        var name: String = nameTextField.text ?? Config.defaultName
        name = name.trimmed.isEmpty ? Config.defaultName : name

        var atk: String = atkTextField.text ?? Config.defaultATK
        atk = atk.trimmed.isEmpty ? Config.defaultATK : atk

        var hp: String = hpTextField.text ?? Config.defaultHP
        hp = hp.trimmed.isEmpty ? Config.defaultHP : hp

        self.name = name
        self.atk = atk
        self.hp = hp

        updateButtonsTitle()
        updateButtonsFont()
    }

    private func updateButtonsTitle() {
        nameButton.setTitle(name, for: .normal)
        atkButton.setTitle(atk, for: .normal)
        hpButton.setTitle(hp, for: .normal)
    }

    private func updateButtonsFont() {
        let nameWidth = name.contentWidth(font: Config.defaultFont)
        let atkWidth = atk.contentWidth(font: Config.defaultFont)
        let hpWidth = hp.contentWidth(font: Config.defaultFont)
        let sumStringsWidth = nameWidth + atkWidth + hpWidth

        let sumSpacing: CGFloat = Config.buttonSpacing * 2 + // There're 3 buttons -> 2 button spacings
            Config.buttonImageWidth * 2 + // There'r 2 buttons that have image, open debug views to get this number
            Config.insideButtonSpacing * 2 // There'r 2 buttons that have image, open debug views to get this number

        let nameRealWidth = ((buttonsContainerView.bounds.width - sumSpacing) / sumStringsWidth * nameWidth)

        let expectedFontSizeToFitNameLabel = ((nameRealWidth / nameWidth) * Config.defaultFontSize).rounded(.down) - 1

        let newFontSize = min(expectedFontSizeToFitNameLabel, Config.defaultFontSize)

        updateButtonFont(nameButton, size: newFontSize)
        updateButtonFont(atkButton, size: newFontSize)
        updateButtonFont(hpButton, size: newFontSize)
    }

    private func updateButtonFont(_ button: UIButton, size: CGFloat) {
        button.titleLabel?.font = UIFont.systemFont(ofSize: size)
    }

    // MARK: - IBAction
    @IBAction func closeBtnTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func applyButtonTouchUpInside(_ sender: Any) {
        updateButtonsTitleAndFont()
    }

    @IBAction func inforButtonTouchUpInside(_ sender: Any) {
        presentInformationAlert()
    }
}

// MARK: - Config
extension DecreaseFontSizeOfButtonsVC {
    struct Config {
        static let defaultName = "Name"
        static let defaultATK = "ATK"
        static let defaultHP = "HP"
        static let defaultFontSize: CGFloat = 15
        static let defaultFont = UIFont.systemFont(ofSize: Config.defaultFontSize)
        static let buttonSpacing: CGFloat = 10
        static let buttonImageWidth: CGFloat = 20
        static let insideButtonSpacing: CGFloat = 0.5
    }
}

// MARK: - UITextFieldDelegate
extension DecreaseFontSizeOfButtonsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
