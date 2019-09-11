//
//  Transaction.swift
//  Moneywell
//
//  Created by Abram Situmorang on 11/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import Foundation
import UIKit

public struct Transaction {
    public static var shared = [
        Transaction(image: UIImage(named: "starbucks")!,
                    merchant: "Starbucks",
                    location: "Jakarta Selatan",
                    time: 2,
                    amount: 40560)
    ]
    
    public let image: UIImage
    public let merchant: String
    public let location: String
    public let time: Int
    public let amount: Int
}
