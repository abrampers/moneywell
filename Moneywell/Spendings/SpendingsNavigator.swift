//
//  FamilyNavigator.swift
//  Moneywell
//
//  Created by Abram Situmorang on 13/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import Shared

internal protocol SpendingsNavigator {
    func toBack()
    func toHahaPage()
    func toCategoryPage(index: Int)
}

internal class DefaultSpendingsNavigator: SpendingsNavigator {
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
    
    internal func toCategoryPage(index: Int) {
        self.navigationController?.pushViewController(CategoryViewController(index: index), animated: true)
    }
}
