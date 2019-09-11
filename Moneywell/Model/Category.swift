//
//  HomeCategories.swift
//  Moneywell
//
//  Created by Abram Situmorang on 10/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import Foundation
import UIKit

public struct Category {
    public static var shared = [
        Category(image: UIImage(named: "food")!,
                 title: "Food & Drinks",
                 amount: 340560,
                 numTransaction: 16),
        Category(image: UIImage(named: "transport")!,
                 title: "Transportation",
                 amount: 213470,
                 numTransaction: 10),
        Category(image: UIImage(named: "entertainment")!,
                 title: "Entertainment",
                 amount: 87220,
                 numTransaction: 7),
        Category(image: UIImage(named: "shopping")!,
                 title: "Shopping",
                 amount: 41590,
                 numTransaction: 6),
    ]
    
    public let image: UIImage
    public let title: String
    public let amount: Int
    public let numTransaction: Int
}
