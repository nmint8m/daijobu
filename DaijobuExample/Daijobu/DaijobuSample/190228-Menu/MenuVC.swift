//
//  MenuVC.swift
//  Artichoke
//
//  Created by Tam Nguyen M. on 8/23/18.
//  Copyright © 2018 Tam Nguyen M. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    func configTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MenuVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell" , for: indexPath)
        cell.textLabel?.text = section.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.row) else { return }
        switch section {
        case .navigationPushCompletion1:
            // MARK: - 181026-NaviPushCompletion
            let vc = NaviPushCompletionVC1()
            let navi = UINavigationController(rootViewController: vc)
            present(navi, animated: true, completion: nil)

        case .navigationPushCompletion2:
            // MARK: - 181026-NaviPushCompletion
            let vc = NaviPushCompletionVC2()
            let navi = UINavigationController(rootViewController: vc)
            present(navi, animated: true, completion: nil)

        case .navigationPushAlongSideTransition:
            // MARK: - 181017-NaviPushAlongsideTransition
            let vc = NaviPushAlongsideTransitionCompletionVC()
            let navi = UINavigationController(rootViewController: vc)
            present(navi, animated: true, completion: nil)

        case .decreaseFontSizeOfMultipleLabels:
            // MARK: - 190301-DecreaseFontSizeOfLabels
            let vc = DecreaseFontSizeOfLabelsVC()
            present(vc, animated: true, completion: nil)

        case .decreaseFontSizeOfMultipleButtons:
            // MARK: - 190301-DecreaseFontSizeOfButtons
            let vc = DecreaseFontSizeOfButtonsVC()
            present(vc, animated: true, completion: nil)

        case .expandlingUITableViewCellWithUIStackView:
            // MARK: - 190303-ExpandingTableViewCellWithStackView
            let vc = ExpandingTableViewCellWithStackViewVC()
            present(vc, animated: true, completion: nil)
        }
    }
}

extension MenuVC {
    enum Section: Int, CaseIterable {
        case navigationPushCompletion1
        case navigationPushCompletion2
        case navigationPushAlongSideTransition
        case decreaseFontSizeOfMultipleLabels
        case decreaseFontSizeOfMultipleButtons
        case expandlingUITableViewCellWithUIStackView

        var title: String {
            switch self {
            case .navigationPushCompletion1:
                return "Navigation Push Completion 1"
            case .navigationPushCompletion2:
                return "Navigation Push Completion 2"
            case .navigationPushAlongSideTransition:
                return "Navigation Push Along Side Transition"
            case .decreaseFontSizeOfMultipleLabels:
                return "Decrease Font Size Of Multiple Labels"
            case .decreaseFontSizeOfMultipleButtons:
                return "Decrease Font Size Of Multiple Buttons"
            case .expandlingUITableViewCellWithUIStackView:
                return "Expanding UITableViewCell With UIStackView"
            }
        }

        static var count: Int {
            return Section.allCases.count
        }
    }
}

