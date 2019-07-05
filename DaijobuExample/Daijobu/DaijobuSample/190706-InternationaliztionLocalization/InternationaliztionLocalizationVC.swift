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
    private var currentLanguageCode: String = ""

    private var currentLanguage: Language {
        get {
            guard let language = Language(rawValue: currentLanguageCode) else {
                    return Language.system
            }
            return language
        }

        set {
            currentLanguageCode = newValue.rawValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InternationaliztionLocalizationVC {

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
    }
}
