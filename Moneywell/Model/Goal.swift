//
//  Goal.swift
//  Moneywell
//
//  Created by Abram Situmorang on 13/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import Foundation
import UIKit

public struct Goal {
    public static let shared = [
        Goal(image: UIImage(named: "goal-bahamas"),
             name: "Vacation to The Bahamas",
             currentAmount: 2875,
             targetAmount: 4600,
             plannedCompletionDate: "January, 2020",
             estimatedCompletionDate: "March, 2020",
             completionDelta: "2 Months Late",
             progressImage: UIImage(named: "progress-54")),
        Goal(image: UIImage(named: "goal-car"),
             name: "New Car",
             currentAmount: 142232,
             targetAmount: 200000,
             plannedCompletionDate: "April, 2021",
             estimatedCompletionDate: "July, 2021",
             completionDelta: "3 Months Late",
             progressImage: UIImage(named: "progress-78")),
    ]
    
    public let image: UIImage?
    public let name: String
    public let currentAmount: Int
    public let targetAmount: Int
    public let plannedCompletionDate: String
    public let estimatedCompletionDate: String
    public let completionDelta: String
    public let progressImage: UIImage?
}
