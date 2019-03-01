//
//  StringExt.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 3/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

extension String {
    func contentWidth(font: UIFont) -> CGFloat {
        let size = (self as NSString).size(withAttributes: [.font: font])
        return size.width
    }
}
