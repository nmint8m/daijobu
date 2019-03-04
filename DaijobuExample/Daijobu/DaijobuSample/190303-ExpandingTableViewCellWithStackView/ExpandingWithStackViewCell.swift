//
//  ExpandingWithStackViewCell.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 3/3/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

protocol ExpandingWithStackViewCellDelegate: class {
    func cell(_ cell: ExpandingWithStackViewCell,
              needsPerform action: ExpandingWithStackViewCell.Action)
}

final class ExpandingWithStackViewCell: UITableViewCell {

    // MARK: - Property
    weak var delegate: ExpandingWithStackViewCellDelegate?

    // MARK: - IBOutlet
    @IBOutlet private weak var titleButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: - Function
    override func awakeFromNib() {
        super.awakeFromNib()
        configCell(isExpanding: false, title: "", description: "")
    }

    func configCell(isExpanding: Bool, title: String, description: String) {
        descriptionLabel.isHidden = !isExpanding
        titleButton.setTitle(title, for: .normal)
        descriptionLabel.text = description
    }

    // MARK: - IBAction
    @IBAction func titleButtonTouchUpInside(_ sender: Any) {
        delegate?.cell(self, needsPerform: .expandOrColapse)
    }
}

extension ExpandingWithStackViewCell {
    enum Action {
        case expandOrColapse
    }
}
