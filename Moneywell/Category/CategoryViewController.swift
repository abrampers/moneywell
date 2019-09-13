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
    private var category: Category
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        
        return view
    }()
    
    private let iconView = UIImageView()
    private let transactionLabel = UILabel()
    private let amountLabel = UILabel()
    
    private lazy var upperStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.iconView, self.transactionLabel, self.amountLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        
        return stack
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.allowsSelection = false
        
        return view
    }()
    
    public init(index: Int) {
        category = Category.shared[index]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .n500
        
        setupUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tableView.frame = CGRect(x: 18, y: upperStack.frame.maxY + 8, width: view.bounds.width - 36, height: tableView.contentSize.height)
    }

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = CGRect(x: 18, y: upperStack.frame.maxY + 8, width: view.bounds.width - 36, height: tableView.contentSize.height)

        let contentHeight = upperStack.frame.maxY + 8 + tableView.contentSize.height + 8
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentHeight)
    }
    
    private func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { (make) in
            make.height.width.equalTo(84)
        }
        
        scrollView.addSubview(upperStack)
        upperStack.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(tableView)
    }
    
    private func setupUI() {
        title = category.title
        iconView.image = category.image
        transactionLabel.attributedText = .text("\(category.numTransaction) Transactions", size: 16, weight: .book, color: .n100)
        amountLabel.attributedText = .text(category.amount.currencyFormat, size: 40, weight: .bold, color: .black)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraints()
    }
}

extension CategoryViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier) as! TransactionTableViewCell
        
        cell.configureCell(transaction: category.transactions[indexPath.section + indexPath.row])
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return category.transactions.count
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
