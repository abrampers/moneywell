//
//  HomeViewController.swift
//  Moneywell
//
//  Created by Abram Situmorang on 09/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

public class CategoryViewController: UIViewController {
    private let categoryTableView: UITableView = {
        let view = UITableView()
        view.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        let headerView = UILabel()
        headerView.attributedText = NSAttributedString.text("Categories", size: 24, weight: .bold, color: .black)
        
        view.backgroundColor = .clear
        view.tableHeaderView = headerView
        view.separatorStyle = .none
        view.allowsSelection = false
        
        return view
    }()
    
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
        
        setupUI()
    }
    
    private func setupUI() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        view.addSubview(categoryTableView)
        categoryTableView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
        }
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var frame = categoryTableView.tableHeaderView?.frame
        frame?.size.height = 37
        
        categoryTableView.tableHeaderView?.frame = frame!
    }
}

extension CategoryViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as! CategoryTableViewCell
        
        cell.configureCell(category: Category.shared[indexPath.section + indexPath.row])
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        print("cell frame", cell.frame)
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return Category.shared.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension CategoryViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
}
