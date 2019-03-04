//
//  ExpandingTableViewCellWithStackViewVC.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 3/3/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class ExpandingTableViewCellWithStackViewVC: UIViewController {

    static let cell = "ExpandingWithStackViewCell"

    var isExpandingData: [Bool] = Array(repeating: false, count: InformationType.count)

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    private func configTableView() {
        let nib = UINib(nibName: ExpandingTableViewCellWithStackViewVC.cell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ExpandingTableViewCellWithStackViewVC.cell)
        tableView.estimatedRowHeight = 500
        tableView.dataSource = self
    }

    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ExpandingTableViewCellWithStackViewVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InformationType.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpandingTableViewCellWithStackViewVC.cell, for: indexPath) as? ExpandingWithStackViewCell,
            indexPath.row < isExpandingData.count,
            let infor = InformationType(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configCell(isExpanding: isExpandingData[indexPath.row],
                        title: infor.title,
                        description: infor.description)
        cell.delegate = self
        return cell
    }
}

extension ExpandingTableViewCellWithStackViewVC: ExpandingWithStackViewCellDelegate {
    func cell(_ cell: ExpandingWithStackViewCell, needsPerform action: ExpandingWithStackViewCell.Action) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        isExpandingData[indexPath.row] = !isExpandingData[indexPath.row]
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}

extension ExpandingTableViewCellWithStackViewVC {
    enum InformationType: Int, CaseIterable {
        case nickname
        case origin
        case weight
        case height
        case coat
        case color
        case lifeSpan

        var title: String {
            switch self {
            case .nickname: return "Nickname"
            case .origin: return "Origin"
            case .weight: return "Weight"
            case .height: return "Height"
            case .coat: return "Coat"
            case .color: return "Color"
            case .lifeSpan: return "Life span"
            }
        }

        var description: String {
            switch self {
            case .nickname: return "Pembroke\nPWC\nPem\nCorgi\nWelsh\nCorgi"
            case .origin: return "Wales, United Kingdom"
            case .weight: return "Male: 11–14 kg\nFemale: 11-13 kg"
            case .height: return "Male: 25–30 cm\nFemale: 25–30 cm"
            case .coat: return "Medium length, thick, weather-resist double coat"
            case .color: return "Fawn\nBlack & Tan\nBlack & White\nRed\nSable"
            case .lifeSpan: return "12 – 15 years"
            }
        }

        static var count: Int {
            return InformationType.allCases.count
        }
    }
}
