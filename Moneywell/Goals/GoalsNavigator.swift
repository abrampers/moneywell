//
//  GoalsNavigator.swift
//  Moneywell
//
//  Created by Abram Situmorang on 13/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import Shared

internal protocol GoalsNavigator {
    func toBack()
    func toHahaPage()
    func toGoalsDetailPage(index: Int)
}

internal class DefaultGoalsNavigator: GoalsNavigator {
    private let navigationController: UINavigationController?
    
    internal init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    internal func toBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    internal func toHahaPage() {
        self.navigationController?.pushViewController(HahaViewController(), animated: true)
    }
    
    internal func toGoalsDetailPage(index: Int) {
        self.navigationController?.pushViewController(GoalsDetailViewController(index: index), animated: true)
    }
}
