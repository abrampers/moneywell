//
//  HomeViewController.swift
//  Moneywell
//
//  Created by Abram Situmorang on 09/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit

public class HomeViewController: UIViewController {
    private let viewModel = HomeViewModel()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        title = "Hello"
        view.backgroundColor = .n500
        
    }
}
