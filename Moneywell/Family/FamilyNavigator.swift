//
//  FamilyNavigator.swift
//  Moneywell
//
//  Created by Abram Situmorang on 13/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import Shared

internal protocol FamilyNavigator {
    func toBack()
    func toHahaPage()
}

internal class DefaultFamilyNavigator: FamilyNavigator {
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
}
