//
//  DefaultNavigationController.swift
//  Moneywell
//
//  Created by Abram Situmorang on 11/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit

class DefaultNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .n500
        navigationBar.prefersLargeTitles = true
        //        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //        navigationBar.shadowImage = UIImage()
    }
}
