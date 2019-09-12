//
//  HahaViewController.swift
//  Moneywell
//
//  Created by Abram Situmorang on 11/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import SnapKit

public class HahaViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Haha"
        view.backgroundColor = .n500

        let label = UILabel()
        label.text = "Haha"
        
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
