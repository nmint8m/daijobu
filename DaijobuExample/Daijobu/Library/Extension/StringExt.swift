//
//  StringExt.swift
//  Daijobu
//
//  Created by Tam Nguyen M. on 3/2/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

extension String {
    
    /// String after trimmed
    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// Width of a string when is set a particular font
    ///
    /// - Parameter font: Font that is set
    /// - Returns: Expected width
    func contentWidth(font: UIFont) -> CGFloat {
        let size = (self as NSString).size(withAttributes: [.font: font])
        return size.width
    }
}
