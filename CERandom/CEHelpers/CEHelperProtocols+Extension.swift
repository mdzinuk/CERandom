//
//  CEHelperProtocols+Extension.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import Foundation
import UIKit

protocol CEReusableView: class {
    static var reuseIdentifier: String { get }
}

protocol CEReusableViewNibLoading: CEReusableView {
    static var nib: UINib { get }
}

extension CEReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension CEReusableViewNibLoading {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension DateFormatter {
    static func isoDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.date(from: dateString)
    }
}
