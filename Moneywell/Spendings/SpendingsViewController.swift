//
//  FamilyViewController.swift
//  Moneywell
//
//  Created by Abram Situmorang on 12/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

internal class SpendingsViewController: UIViewController {
    private let rx_disposeBag = DisposeBag()
    private let categorySubject = PublishSubject<Int>()
    
    private lazy var navigator: SpendingsNavigator = {
        let nav = DefaultSpendingsNavigator(navigationController: self.navigationController)
        return nav
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        
        return view
    }()
    
    private let spendingView = SpendingView(spending: Spending(amount: 634123, delta: 23))
    
    private let limitView = LimitView()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        let headerView = UILabel()
        headerView.attributedText = NSAttributedString.text("Categories", size: 24, weight: .bold, color: .black)
        
        view.backgroundColor = .clear
        view.tableHeaderView = headerView
        view.separatorStyle = .none
        view.allowsSelection = true
        view.isScrollEnabled = false
        
        return view
    }()

    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Your Family"
        view.backgroundColor = .n500
        
        setupUI()
        bindUI()
    }
    
    internal override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.frame = CGRect(x: 18, y: limitView.frame.maxY + 8, width: view.bounds.width - 36, height: tableView.contentSize.height)
    }
    
    internal override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var frame = tableView.tableHeaderView?.frame
        frame?.size.height = 37
        
        tableView.tableHeaderView?.frame = frame!
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 18, y: limitView.frame.maxY + 8, width: view.bounds.width - 36, height: tableView.contentSize.height)
        
        let contentHeight = limitView.frame.maxY + 8 + tableView.contentSize.height + 8
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentHeight)
    }
    
    private func setupUI() {
        title = "Spendings"
        view.backgroundColor = .n500
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tabBarItem = UITabBarItem(title: "",
                                  image: UIImage(named: "spendings-deselected")?.withRenderingMode(.alwaysOriginal),
                                  selectedImage: UIImage(named: "spendings-selected")?.withRenderingMode(.alwaysOriginal))
        
        setupConstraints()
    }
    

    private func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(spendingView)
        spendingView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(limitView)
        limitView.snp.makeConstraints { [spendingView] (make) in
            make.top.equalTo(spendingView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(tableView)
    }
    
    private func bindUI() {
        limitView.rx.tap
            .asDriver()
            .drive(onNext: { [navigator] (_) in
                navigator.toHahaPage()
            })
            .disposed(by: rx_disposeBag)
        
        categorySubject
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [navigator] (index) in
                navigator.toCategoryPage(index: index)
            })
            .disposed(by: rx_disposeBag)
    }
}

extension SpendingsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        categorySubject.onNext(indexPath.section + indexPath.row)
    }
}

extension SpendingsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as! CategoryTableViewCell
        
        cell.configureCell(category: Category.shared[indexPath.section + indexPath.row])
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return Category.shared.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
