//
//  InternationaliztionLocalizationVC.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 7/4/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class InternationaliztionLocalizationVC: ViewController {

    // MARK: - IBOutlet

    // MARK: - Properties

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func languageButtonTouchUpInside(_ sender: UIButton) {
        guard let buttonType = ButtonType(rawValue: sender.tag) else { return }
        let newLanguage: Language
        switch buttonType {
        case .english:
            newLanguage = .english
        case .arabic:
            newLanguage = .arabic
        }
        Language.currentAppleLanguage = newLanguage
        let alert = UIAlertController(title: "Do you want to change language to \(newLanguage.name)?",
                                      message: "You need to restart app to appl",
                                      preferredStyle: .alert)
        let restart = UIAlertAction(title: "Restart app", style: .default) { _ in
            exit(0)
        }
        let cancel = UIAlertAction(title: "Don't apply", style: .cancel, handler: nil)
        alert.addAction(restart)
        alert.addAction(cancel)
        present(alert,
                animated: true,
                completion: nil)
    }
}

extension InternationaliztionLocalizationVC {

    enum ButtonType: Int {
        case english
        case arabic
    }
}

enum Language: String, CaseIterable {
    case english = "en"
    case arabic = "ar"

    var name: String {
        switch self {
        case .english: return "English"
        case .arabic: return "Arabic"
        }
    }

    static let count: Int = {
        return Language.allCases.count
    }()

    static let system: Language = {
        guard let languageCode = Locale.preferredLanguages.first?.prefix(2),
            let language = Language(rawValue: String(languageCode)) else
        {
            return Language.english
        }
        return language
    }()

    static var currentAppleLanguage: Language {

        get {
            let kAppLanguage = "AppleLanguages"
            let ud = UserDefaults.standard

            guard let languageCode = ud.string(forKey: kAppLanguage),
                let language = Language(rawValue: languageCode) else {
                    return Language.system
            }
            return language
        }

        set {
            let kAppLanguage = "AppleLanguages"
            let ud = UserDefaults.standard

            ud.set([newValue.rawValue], forKey: kAppLanguage)
            ud.synchronize()
        }
    }
}
