//
//  Int+Extension.swift
//  Moneywell
//
//  Created by Abram Situmorang on 10/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import Foundation

extension Int {
    public var currencyFormat: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        return currencyFormatter.string(from: NSNumber(value: self))!
    }
}
